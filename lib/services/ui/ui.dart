import 'dart:async';
import 'package:editor/services/websocket/models/server_class_defs/message_types.dart';
import 'package:editor/services/websocket/remote_connection.dart';
import 'package:editor/services/websocket/remote_provider.dart';
import 'package:editor/widgets/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:editor/services/ui/menu.dart';

class Popup {
  Popup({
    required this.widget,
    this.isMenu = false,
  });
  bool isMenu = false;
  Widget widget;
}

class UIProvider extends ChangeNotifier {
  Map<String, Function?> actions = <String, Function?>{};
  List<Popup> popups = <Popup>[];
  Popup? error;
  Map<String, UIMenuData> menus = {};

  int menuIndex = 0;
  Function? onClearPopups;

  /// So we can listen to errors from the server and show them
  StreamSubscription? sub;

  UIMenuData? menu(String id, {void Function(UIMenuData)? onSelect}) {
    menus[id] = menus[id] ?? UIMenuData();
    menus[id]?.onSelect = onSelect ?? menus[id]?.onSelect;
    return menus[id];
  }

  bool hasPopups() {
    return popups.isNotEmpty;
  }

  void remoteChange(RemoteProvider remote) {
    if (remote.connected) {
      sub = remote.remote!.messages!.listen((msg) => errorListener(msg));
    } else {
      sub?.cancel();
    }
  }

  void errorListener(ServerMessage msg) {
    if (msg.type == ServerMessageType.error) {
      setError(ErrorModal(text: msg.content['message']));
    }
  }

  void setError(Widget child) {
    error = Popup(
        widget: GestureDetector(
            onTap: () {
              popPopup();
            },
            child: Stack(children: [
              Container(color: Colors.black.withOpacity(0.5)),
              child
            ])),
        isMenu: child is UIMenuPopup);
    notifyListeners();
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  /// Blur = background blur. Shield = if clicking off the modal should close it
  void setPopup(Widget widget,
      {bool blur = false, bool shield = false, Function? onClearPopups}) {
    this.onClearPopups = null;
    clearPopups();
    pushPopup(widget, blur: blur, shield: shield, onClearPopups: onClearPopups);
  }

  void pushPopup(Widget widget,
      {bool blur = false, bool shield = false, Function? onClearPopups}) {
    this.onClearPopups = onClearPopups;
    if (blur || shield) {
      popups.add(Popup(
          widget: GestureDetector(
              onTap: () {
                if (shield) {
                  popPopup();
                }
              },
              child: Stack(children: [
                Container(color: Colors.black.withOpacity(blur ? 0.5 : 0.015)),
                widget
              ])),
          isMenu: widget is UIMenuPopup));
    } else {
      popups.add(Popup(
          widget: Stack(children: [widget]), isMenu: widget is UIMenuPopup));
    }
    notifyListeners();
  }

  void popPopup() {
    if (popups.isNotEmpty) {
      popups.removeLast();
      Future.delayed(const Duration(milliseconds: 50), notifyListeners);
      if (popups.isEmpty) {
        onClearPopups?.call();
      }
    }
  }

  void clearPopups() {
    if (popups.isNotEmpty) {
      popups.clear();
      Future.delayed(const Duration(milliseconds: 50), notifyListeners);
      onClearPopups?.call();
    }
  }

  void clearMenus() {
    if (popups.isNotEmpty) {
      if (popups[0].isMenu) {
        popups.clear();
        Future.delayed(const Duration(milliseconds: 50), notifyListeners);
        onClearPopups?.call();
      }
    }
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }
}
