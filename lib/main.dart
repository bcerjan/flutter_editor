import 'dart:io';
import 'package:editor/services/websocket/remote_provider.dart';
import 'package:editor/services/websocket/websocket_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as _path;

import 'package:editor/editor/controller.dart';
import 'package:editor/editor/document.dart';
import 'package:editor/layout/layout.dart';
import 'package:editor/layout/explorer.dart';
import 'package:editor/services/app.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/indexer/filesearch.dart';
import 'package:editor/services/ui/ui.dart';
import 'package:editor/services/ui/status.dart';
import 'package:editor/services/highlight/theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  CodeEditingController.configure();

  AppProvider app = AppProvider.instance();
  await app.initialize();
  await app.loadSettings();

  // String path = './';
  // if (args.isNotEmpty) {
  //   path = args[0];
  // }

  HLTheme theme = HLTheme.instance();
  // TMParser()
  //   ..loadTheme(app.settings['theme'] ?? 'Monokai')
  //   ..loadIcons('material-icon-theme');

  UIProvider ui = UIProvider();
  StatusProvider status = StatusProvider();
  FileSearchProvider fileSearch = FileSearchProvider();
  RemoteProvider remote = RemoteProvider<WebsocketConnection>();

  // String dirPath = path;
  // if (!(await FileSystemEntity.isDirectory(path))) {
  //   Document? doc = app.open(path);

  //   // FFIBridge.createDocument(doc?.documentId ?? 0, doc?.docPath ?? '');

  //   app.openSidebar = false;
  //   dirPath = _path.dirname(path);
  // }

  ExplorerProvider explorer = ExplorerProvider<WebsocketConnection>();

  /// Register our other objects so they are automatically updated when we
  /// connect/disconnect from the server:
  remote.addListener(() {
    explorer.remoteChange(remote);
    ui.remoteChange(remote);
    if (explorer.explorer.backend != null) {
      Future.delayed(const Duration(milliseconds: 50));

      /// We always start with the root of the server's workspace directory
      // explorer.explorer.setRootPath(r'').then((_) {
      //   explorer.explorer.root?.isExpanded = true;
      //   explorer.rebuild();
      // });
      explorer.explorer.getWorkingDirectory();
      Future.delayed(
          const Duration(milliseconds: 50), () => explorer.rebuild());
    }
    // explorer.explorer.backend?.loadPath(app.codeFolder);
    fileSearch.remoteChange(remote);
    app.remoteChange(remote);
  });

  // exclude patterns
  dynamic folderExclude = app.settings['folder_exclude_patterns'] ?? [];
  dynamic fileExclude = app.settings['file_exclude_patterns'] ?? [];
  dynamic binaryExclude = app.settings['binary_file_patterns'] ?? [];
  // fileSearch.setExcludePatterns(folderExclude, fileExclude, binaryExclude);
  explorer.explorer
      .setExcludePatterns(folderExclude, fileExclude, binaryExclude);

  // explorer.explorer.setRootPath(dirPath).then((files) {
  //   explorer.explorer.root?.isExpanded = true;
  //   // explorer.explorer.dump();
  // explorer.rebuild();
  //   // explorer.explorer.backend?.preload();
  // });
  // explorer.explorer.backend?.setRootPath(dirPath); // preloads 4 depths

  explorer.onSelect = (item) {
    if (item != null) {
      if (!item.isDirectory) {
        if (!app.fixedSidebar) {
          app.openSidebar = false;
        }
        app.open(item.fullPath, focus: true);
      }
    }
  };

  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => app),
    ChangeNotifierProvider(create: (context) => ui),
    ChangeNotifierProvider(create: (context) => theme),
    ChangeNotifierProvider(create: (context) => explorer),
    ChangeNotifierProvider(create: (context) => status),
    Provider(create: (context) => fileSearch),
    ChangeNotifierProvider(create: (context) => remote),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({this.focusNode});
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    HLTheme theme = Provider.of<HLTheme>(context);

    Brightness scheme = Brightness
        .light; // isDark(theme.background) ? Brightness.dark : Brightness.light;

    ThemeData themeData = ThemeData(
      focusColor: const Color.fromRGBO(0, 0, 0, 0.1),
      brightness: scheme,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: toMaterialColor(theme.background),
        accentColor: toMaterialColor(theme.background),
        brightness: scheme,
        backgroundColor: theme.background,
        errorColor: Colors.red,
      ),
      primarySwatch: toMaterialColor(darken(theme.background, sidebarDarken)),
      primaryColor: theme.comment,
      scaffoldBackgroundColor: theme.background,
      fontFamily: theme.uiFontFamily,
      //fontSize: theme.uiFontSize,
      textTheme: TextTheme().apply(
        bodyColor: theme.comment,
        displayColor: theme.comment,
        fontFamily: theme.uiFontFamily,
        //fontSize: theme.fontSize
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: const Color(0xc0c0c0c0).withOpacity(0.1),
        cursorColor: theme.comment,
        selectionHandleColor: const Color(0xc0c0c0c0).withOpacity(0.1),
      ),
      // scrollbarTheme: const ScrollbarThemeData().copyWith(
      //     thumbColor:
      //         MaterialStateProperty.all(const Color.fromRGBO(255, 255, 0, 0))),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const TheApp(),
    );
  }
}
