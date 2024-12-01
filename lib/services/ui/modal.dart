import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:editor/services/app.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/ui/ui.dart';
import 'package:editor/services/highlight/theme.dart';

class UIButton extends StatelessWidget {
  const UIButton({Key? key, this.text, this.onTap}) : super(key: key);

  final String? text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    HLTheme theme = Provider.of<HLTheme>(context);
    TextStyle style = TextStyle(
        fontFamily: theme.uiFontFamily,
        fontSize: theme.fontSize,
        letterSpacing: -0.5,
        color: theme.foreground);
    return InkWell(
        canRequestFocus: false,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text('$text', style: style)),
        onTap: () {
          onTap?.call();
        });
  }
}

// For text inputs
class UITextInput extends StatelessWidget {
  const UITextInput({
    Key? key,
    this.label,
    this.text,
    this.onChanged,
    this.required = true,
    this.editable = true,
  }) : super(key: key);

  final String? label;
  final String? text;
  final Function(String)? onChanged;
  final bool required;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    HLTheme theme = Provider.of<HLTheme>(context);
    TextStyle style = TextStyle(
        fontFamily: theme.uiFontFamily,
        fontSize: theme.fontSize,
        letterSpacing: -0.5,
        color: theme.foreground);
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Tooltip(
            message: label,
            child: TextFormField(
              decoration: InputDecoration.collapsed(hintText: label),
              readOnly: !editable,
              initialValue: '$text',
              style: style,
              onChanged: (val) {
                if (onChanged != null && val.isNotEmpty) {
                  onChanged!(val);
                }
              },
              autovalidateMode: required
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (value) {
                if (required) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                } else {
                  return null;
                }
              },
            )));
  }
}

class UIModal extends StatefulWidget {
  const UIModal({
    key,
    this.title,
    this.message,
    this.position = Offset.zero,
    this.width = 220,
    this.buttons = const [],
    this.inputs = const [],
  }) : super(key: key);

  final double width;
  final String? title;
  final String? message;
  final Offset position;
  final List<UIButton> buttons;
  final List<UITextInput> inputs;

  @override
  _UIModal createState() => _UIModal();
}

class _UIModal extends State<UIModal> {
  @override
  Widget build(BuildContext context) {
    HLTheme theme = Provider.of<HLTheme>(context);
    AppProvider app = Provider.of<AppProvider>(context);
    UIProvider ui = Provider.of<UIProvider>(context);

    _cancel() {
      Future.delayed(const Duration(microseconds: 0), () {
        ui.clearPopups();
      });
      return Container();
    }

    TextStyle style = TextStyle(
        fontFamily: theme.uiFontFamily,
        fontSize: theme.uiFontSize,
        letterSpacing: -0.5,
        color: theme.comment);
    Color bg = darken(theme.background, sidebarDarken);

    double maxWidth = widget.width;
    double padding = 8;

    List<Widget> items = [
      if (widget.title != null) ...[
        Text('${widget.title}', style: style.copyWith(color: theme.function))
      ],
      if (widget.message != null) ...[
        Center(child: Text('${widget.message}', style: style))
      ],
    ]
        .map((item) => Padding(padding: const EdgeInsets.all(4), child: item))
        .toList();

    List<Widget> inputs = widget.inputs
        .map((input) => Padding(
              padding: const EdgeInsets.all(4),
              child: input,
            ))
        .toList();

    return Positioned.fill(
        // top: position.dy,
        // left: position.dx,
        child: Padding(
            padding: EdgeInsets.only(bottom: app.screenHeight > 200 ? 80 : 0),
            child: Align(
                alignment: Alignment.center,
                child: Material(
                    color: bg,
                    // borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                        width: maxWidth,
                        decoration: BoxDecoration(
                            // color: bg,
                            border: Border.all(
                                color: darken(theme.background, 0),
                                width: 1.5)),
                        child: Padding(
                            padding: EdgeInsets.all(padding),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, //Center Row contents vertically,,
                                children: [
                                  ...items,
                                  ...inputs,
                                  if (widget.buttons.isNotEmpty) ...[
                                    Row(
                                        children: widget.buttons,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, //Center Row contents horizontally,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center //Center Row contents vertically,
                                        )
                                  ],
                                ])))))));
  }
}
