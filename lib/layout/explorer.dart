import 'dart:io';
import 'dart:async';
import 'package:editor/services/explorer/remotefs.dart';
import 'package:editor/services/websocket/models/server_class_defs/file_node.dart';
import 'package:editor/services/websocket/models/server_class_defs/message_types.dart';
import 'package:editor/services/websocket/remote_connection.dart';
import 'package:editor/services/websocket/remote_provider.dart';
import 'package:editor/services/websocket/websocket_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as _path;
import 'package:editor/services/app.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/ui/ui.dart';
import 'package:editor/services/ui/menu.dart';
import 'package:editor/services/ui/modal.dart';
import 'package:editor/services/highlight/theme.dart';
import 'package:editor/services/highlight/highlighter.dart';
import 'package:editor/services/explorer/filesystem.dart';
import 'package:editor/services/explorer/localfs.dart';
import 'package:editor/services/explorer/sftp.dart';

const int animateK = 55;

class FileIcon extends StatefulWidget {
  FileIcon({this.path = '', this.size = 20}) : super(key: ValueKey(path));

  final String path;
  final double size;

  @override
  _FileIcon createState() => _FileIcon();
}

class _FileIcon extends State<FileIcon> {
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null && widget.path != '') {
      File iconFile = File(widget.path);
      icon = SvgPicture.file(iconFile, width: widget.size, height: widget.size);
    }
    return icon ?? Container();
  }
}

class ExplorerProvider<T extends RemoteConnection> extends ChangeNotifier
    implements ExplorerListener {
  late Explorer explorer;

  Map<String, String> gitStatus = {};
  List<ExplorerItem?> tree = [];
  ExplorerItem? selected;
  bool animate = false;

  Function(ExplorerItem?)? onSelect;

  ExplorerProvider() {
    explorer = Explorer();
    // explorer.setBackend(LocalFs());
    // explorer.setBackend(RemoteFs(wsConnection: wsConnection, msgStream: msgStream))
    // explorer.setBackend(SFtpFs());
    // explorer.backend?.addListener(this);
  }

  void remoteChange(RemoteProvider<T> provider) {
    if (provider.remote != null) {
      explorer.setBackend(RemoteFs<T>());
      explorer.backend?.updateConnection(provider.remote);
    } else {
      explorer.backend?.updateConnection(provider.remote);
      explorer.setBackend(null);
      tree = [];
      explorer.root = null;
      rebuild();
    }
  }

  // void initializeRemote({
  //   required T wsConnection,
  //   required Stream<ServerMessage> msgStream,
  // }) {
  //   explorer.backend?.addListener(this);
  //   notifyListeners();
  // }

  void onLoad(dynamic items) {
    rebuild();
  }

  void onCreate(dynamic item) {
    rebuild();
  }

  void onDelete(dynamic item) {
    rebuild();
  }

  void onError(dynamic error) {}

  void select(ExplorerItem? item) {
    selected = item;
    onSelect?.call(item); // typically app.open -> codeController.open
  }

  void rebuild() async {
    // update_git_status();
    List<ExplorerItem?> _previous = [...tree];
    tree = explorer.tree();
    if (!animate) {
      for (final i in tree) {
        i?.height = 1;
      }
      notifyListeners();
      return;
    }

    Map<ExplorerItem?, List<bool>> hash = {};
    _previous.forEach((item) {
      hash[item] = hash[item] ?? [false, false];
      hash[item]?[0] = true;
    });
    tree.forEach((item) {
      hash[item] = hash[item] ?? [false, false];
      hash[item]?[1] = true;
    });

    List<ExplorerItem?> added = [];
    List<ExplorerItem?> removed = [];

    int interval = animateK;

    for (final k in hash.keys) {
      if (hash[k]?[0] == true && hash[k]?[1] == true) continue;
      if (hash[k]?[0] == true) {
        k?.height = 0;
        removed.add(k);

        Future.delayed(Duration(milliseconds: removed.length * interval), () {
          k?.height = 0;
          k?.duration = removed.length * interval;
          notifyListeners();
        });
      }
      if (hash[k]?[1] == true) {
        added.add(k);
        Future.delayed(Duration(milliseconds: added.length * interval), () {
          k?.height = 1;
          k?.duration = added.length * interval;
          notifyListeners();
        });

        interval -= 2;
        if (interval < 0) interval = 0;
      }
    }

    notifyListeners();
  }

  // void update_git_status() {
  //   if (tree.length == 0) return;

  //   Completer<void> c = Completer<void>();
  //   gitStatus = {};

  //   FFIMessaging.instance().sendMessage({
  //     'channel': 'git',
  //     'message': {'command': 'status', 'path': '${(tree[0]?.fullPath ?? '')}/'}
  //   }).then((res) {
  //     if (res == null) return;

  //     String status = '';
  //     for (dynamic l in res['message']) {
  //       if (l.contains('modified:')) {
  //         status = 'modified';
  //       }
  //       if (l.contains('new file:')) {
  //         status = 'new';
  //       }
  //       if (l.contains('deleted:')) {
  //         status = 'deleted';
  //       }
  //       if (l.contains('Untracked files:')) {
  //         status = 'untracked';
  //         continue;
  //       }

  //       List<String> ss = l.split(':');
  //       String s = '';
  //       if (ss.length > 1) {
  //         s = ss[1].trim();
  //       }

  //       if (status == 'untracked') {
  //         s = l.trim();
  //       }

  //       if (s == '') continue;

  //       ExplorerItem? root = tree[0]?.rootItem()!;
  //       s = _path.normalize(_path.join(root?.fullPath ?? '', s));
  //       gitStatus[s] = status;
  //       // print('$status $s');
  //     }

  //     bool shouldNotify = false;
  //     for (var i in tree) {
  //       i?.extraData = i.extraData ?? {};
  //       String? itemStatus = gitStatus[i?.fullPath ?? ''];
  //       if (i?.extraData['status'] != itemStatus) {
  //         i?.extraData['status'] = itemStatus;
  //         shouldNotify = true;
  //       }
  //     }

  //     if (shouldNotify) {
  //       notifyListeners();
  //     }
  //   });
  // }
}

class ExplorerTreeItem extends StatelessWidget {
  const ExplorerTreeItem({
    super.key,
    this.item,
    this.provider,
    this.style,
  });

  final ExplorerItem? item;
  final ExplorerProvider? provider;
  final TextStyle? style;

  void showContextMenu(BuildContext context) {
    RenderObject? obj = context.findRenderObject();
    if (obj != null) {
      RenderBox? box = obj as RenderBox;
      Offset position = box.localToGlobal(Offset(box.size.width, 0));
      UIProvider ui = Provider.of<UIProvider>(context, listen: false);
      UIMenuData? menu = ui.menu('explorer::context', onSelect: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          ui.setPopup(UIModal(message: 'Delete?'));
        });
      });
      menu?.items.clear();
      menu?.menuIndex = -1;
      for (final s in ['New Folder', 'New File']) {
        menu?.items.add(UIMenuData()..title = s);
      }
      ui.setPopup(
          UIMenuPopup(
            position: position,
            alignX: -2,
            alignY: 0,
            menu: menu,
          ),
          blur: false,
          shield: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider app = Provider.of<AppProvider>(context);
    UIProvider ui = Provider.of<UIProvider>(context);
    HLTheme theme = Provider.of<HLTheme>(context);
    ExplorerItem _item = item ?? ExplorerItem(path: Uri.file(''));
    bool expanded = _item.isExpanded;

    double size = 16;
    Widget icon = _item.isDirectory
        ? Icon((expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            size: size, color: theme.comment)
        : Container(width: size);

    bool isFocused = item?.path.path == app.document?.docPath;
    TextStyle? _style =
        style?.copyWith(color: isFocused ? theme.foreground : theme.comment);

    // String iconPath = FFIBridge.iconForFileName(item?.fileName ?? '');
    Widget? fileIcon;

    if (_item.isDirectory) {
      fileIcon =
          Icon(Icons.folder, size: theme.uiFontSize + 2, color: theme.comment);
    } else {
      fileIcon = Padding(
          padding: EdgeInsets.only(left: 0 * theme.uiFontSize / 2),
          child: FileIcon(
              path: '', size: theme.uiFontSize + 2)); //TODO: update icon path
    }

    Widget button = InkWell(
        canRequestFocus: false,
        child: GestureDetector(
            onSecondaryTapDown: (details) {
              print(_item.path.path);
              showContextMenu(context);
            },
            child: Container(
                color: isFocused ? theme.selection.withOpacity(0.2) : null,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        height: 32,
                        child: Row(children: [
                          Container(width: _item.depth * size / 2),
                          Padding(
                              child: icon, padding: const EdgeInsets.all(2)),
                          fileIcon,
                          Text(
                            ' ${_item.name}',
                            style: _style,
                            maxLines: 1,
                          ),
                        ]))))),
        onTap: () {
          ui.clearPopups();
          if (_item.isDirectory) {
            _item.isExpanded = !expanded;
            if (_item.isExpanded) {
              provider?.explorer
                  .loadPath(_item.path.getRegularPath())
                  .then((_) => provider?.rebuild());

              // provider?.explorer.toggleExpand(_item).then((val) {
              //   print(provider?.explorer.root?.children);
              //   if (!_item.isExpanded) {
              //     provider?.explorer
              //         .loadPath(_item.path.getRegularPath())
              //         .then((_) => provider?.rebuild());
            } else {
              provider?.rebuild();
            }
          }
          provider?.select(_item);
        });

    Widget? statusItem;
    if (_item.extraData != null && _item.extraData['status'] != null) {
      String stat = _item.extraData['status'] ?? '';
      Color clr = Colors.yellow;
      switch (stat) {
        case 'modified':
          clr = Colors.blue;
          break;
        case 'new':
          clr = Colors.green;
          break;
        case 'untracked':
          clr = Colors.grey;
          break;
      }
      statusItem = Padding(
          padding: EdgeInsets.only(right: 8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.circle, size: 6, color: clr)));
    }

    return Stack(children: [
      Container(width: app.sidebarWidth, child: button),
      statusItem ?? Container()
    ]);
  }
}

class ExplorerTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider app = Provider.of<AppProvider>(context);
    ExplorerProvider exp = Provider.of<ExplorerProvider>(context);

    HLTheme theme = Provider.of<HLTheme>(context);
    TextStyle style = TextStyle(
        fontSize: theme.uiFontSize,
        fontFamily: theme.uiFontFamily,
        letterSpacing: -0.5,
        color: theme.comment);

    Size sz = getTextExtents('item', style);
    double itemHeight = sz.height + 8;
    List<ExplorerTreeItem> tree = [
      ...exp.tree.map((item) => ExplorerTreeItem(
            item: item,
            provider: exp,
            style: style,
          ))
    ];

    Widget _animate(
        {Key? key,
        Widget? child,
        double height = 0,
        double opacity = 0,
        bool animate = true}) {
      if (!animate) {
        return Container(height: height, child: child);
      }

      return AnimatedOpacity(
          key: ValueKey(key),
          curve: Curves.decelerate,
          duration: Duration(milliseconds: animateK * 4), //animateK * 3),
          opacity: opacity,
          // child: AnimatedSize(
          //     clipBehavior: Clip.hardEdge,
          //     curve: Curves.decelerate,
          //     duration: Duration(milliseconds: animateK * 2),
          //     child: AnimatedPadding(
          //         padding: EdgeInsets.only(left: (itemHeight - height) * 4 * 0),
          //         curve: Curves.decelerate,
          //         duration: Duration(milliseconds: animateK * 2),
          child: Container(height: height, child: child)
          // ))
          );
    }

    return Material(
        color: darken(theme.background, sidebarDarken),
        child: Container(
            height: app.screenHeight,
            width: app.sidebarWidth,
            child: ListView.builder(
                itemCount: tree.length,
                itemBuilder: (BuildContext context, int index) {
                  ExplorerTreeItem _node = tree[index];
                  double h = itemHeight * (_node.item?.height ?? 0);
                  double o = 1 * (_node.item?.height ?? 0);
                  return _animate(
                      key: ValueKey(_node.item),
                      child: _node, //.build(context),
                      height: h,
                      opacity: o,
                      animate: exp.animate);
                })));
  }
}
