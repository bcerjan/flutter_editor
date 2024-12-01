import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:editor/services/app.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/ui/ui.dart';
import 'package:editor/services/highlight/theme.dart';

class UIMenuData {
  int menuIndex = 0;
  String title = '';
  String subtitle = '';
  dynamic data;
  int score = 0;
  List<UIMenuData> items = [];

  Function? onSelect;

  void select(int index) {
    if (index >= 0 && index < items.length) {
      items[index].onSelect?.call(items[index]);
    }
  }

  void selectItem(UIMenuData? item) {
    if (item != null) {
      item.onSelect?.call(item);
    }
  }

  @override
  String toString() {
    return title;
  }
}

class UIMenuPopup extends StatefulWidget {
  UIMenuPopup(
      {Key? key,
      Offset this.position = Offset.zero,
      double this.width = 220,
      int this.visibleItems = 8,
      double this.alignX = 0,
      double this.alignY = 0,
      UIMenuData? this.menu})
      : super(key: key);

  double width = 220;
  int visibleItems = 8;
  double alignX = 0;
  double alignY = 0;
  Offset position = Offset.zero;
  UIMenuData? menu;

  @override
  _UIMenuPopup createState() => _UIMenuPopup();
}

class _UIMenuPopup extends State<UIMenuPopup> {
  late ScrollController scroller;
  late FocusNode rawInputNode;

  @override
  void initState() {
    super.initState();
    rawInputNode = FocusNode();
    scroller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    rawInputNode.dispose();
    scroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HLTheme theme = Provider.of<HLTheme>(context);
    AppProvider app = Provider.of<AppProvider>(context);
    UIProvider ui = Provider.of<UIProvider>(context);

    Offset position = widget.position;
    UIMenuData? menu = widget.menu;

    _cancel() {
      Future.delayed(const Duration(microseconds: 0), () {
        ui.clearPopups();
      });
      return Container();
    }

    List<UIMenuData?> items = menu?.items ?? [];
    if (items.isEmpty) {
      return _cancel();
    }

    TextStyle style = TextStyle(
        fontFamily: theme.uiFontFamily,
        fontSize: theme.uiFontSize,
        letterSpacing: -0.5,
        color: theme.comment);
    Color bg = darken(theme.background, sidebarDarken);

    double maxWidth = widget.width;
    int maxItems = widget.visibleItems;

    double padding = 2;
    Size extents = getTextExtents(' ', style);
    double itemHeight = (extents.height + 2 + (padding * 2));
    int itemsCount = items.length;
    if (itemsCount > maxItems) itemsCount = maxItems;
    double height = 5 + (itemHeight + 1.5) * itemsCount;

    double dx = position.dx + (extents.width * widget.alignX);
    double dy = position.dy + (itemHeight * widget.alignY);
    if (dx + maxWidth > app.screenWidth + 2) {
      dx = app.screenWidth - 2 - maxWidth;
    }
    if (dy + height > app.screenHeight - 40) {
      dy = position.dy - height - 4;
    }

    Offset _position = Offset(dx, dy);

    if (scroller.positions.isNotEmpty) {
      double start = scroller.position.pixels / itemHeight;
      double end = start + maxItems;
      int index = menu?.menuIndex ?? 0;
      if (index < start || index >= end) {
        double target = index * itemHeight - (height / 2.5);
        if (target < 0) {
          target = 0;
        }
        if (target > scroller.position.maxScrollExtent) {
          target = scroller.position.maxScrollExtent;
        }
        scroller.jumpTo(target);
      }
    }

    Widget _item(BuildContext context, int index) {
      UIMenuData? item = items[index];
      String s = item?.title ?? '';
      return InkWell(
          onTap: () {
            menu?.select(index);
            ui.clearPopups();
          },
          child: Padding(
              padding: EdgeInsets.all(padding),
              child: Container(
                  color: index == menu?.menuIndex ? theme.background : null,
                  width: maxWidth,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(' $s  ',
                          // style: index == decor.menuIndex
                          //     ? style.copyWith(color: theme.foreground)
                          //     : style,
                          style: style.copyWith(color: theme.comment),
                          softWrap: false,
                          overflow: TextOverflow.clip)))));
    }

    return Positioned(
        top: _position.dy,
        left: _position.dx,
        child: Material(
            color: bg,
            child: Container(
                width: maxWidth + padding,
                height: height,
                decoration: BoxDecoration(
                    // color: bg,
                    border: Border.all(
                        color: darken(theme.background, 0), width: 1.5)),
                child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: RawKeyboardListener(
                        focusNode: rawInputNode,
                        autofocus: true,
                        onKey: (RawKeyEvent event) {
                          // editor -- aggressively regains focus
                          // if (event.runtimeType.toString() == 'RawKeyDownEvent') {
                          // String keys = buildKeys(event.logicalKey.keyLabel,
                          // control: event.isControlPressed,
                          // shift: event.isShiftPressed,
                          // alt: event.isAltPressed);
                          // int idx = menu?.menuIndex ?? 0;
                          // int size = menu?.items.length ?? 0;
                          // switch(keys) {
                          // case 'up':
                          // if (idx > 0) {
                          // menu?.menuIndex--;
                          // setState(() {});
                          // }
                          // return;
                          // case 'down':
                          // if (idx + 1 < size) {
                          // menu?.menuIndex++;
                          // setState(() {});
                          // }
                          // return;
                          // case 'enter':
                          // {
                          // menu?.select(menu?.menuIndex ?? -1);
                          // ui.clearPopups();
                          // return;
                          // }
                          // }
                          // }
                        },
                        child: ListView.builder(
                            controller: scroller,
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                            itemExtent: itemHeight,
                            itemBuilder: _item))))));
  }
}
