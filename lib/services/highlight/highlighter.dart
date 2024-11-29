import 'package:editor/services/highlight/fhl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:editor/editor/cursor.dart';
import 'package:editor/editor/block.dart';
import 'package:editor/editor/document.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/highlight/theme.dart';
import 'package:editor/services/highlight/tmparser.dart';

abstract class HLEngine {
  List<LineDecoration> run(Block? block, int line, Document document);

  void loadTheme(String path);
  HLLanguage loadLanguage(String filename);
  HLLanguage? language(int id);
}

abstract class HLLanguage {
  int langId = 0;
  List<String> blockComment = [];
  String lineComment = '';
  Map<String, String> brackets = {};
  Map<String, String> autoClose = {};
  List<String> closingBrackets = [];
}

class CustomWidgetSpan extends WidgetSpan {
  int line = 0;
  Block? block;
  CustomWidgetSpan({required Widget child, this.line = 0, this.block})
      : super(child: child);
}

class Highlighter {
  // HLEngine engine = TMParser(); // original, likely need to replace anyway
  HLEngine engine = FlutterHighlight();

  TextSpan _textSpan(String text, TextStyle style,
      {Function? onTap, Block? block}) {
    return TextSpan(
        text: text,
        style: style,
        recognizer: style.fontFamilyFallback == null
            ? null
            : (TapGestureRecognizer()
              ..onTap = () {
                for (final t in (style.fontFamilyFallback ?? [])) {
                  onTap?.call('$t');
                }
              }),
        mouseCursor: style.fontFamilyFallback != null
            ? MaterialStateMouseCursor.clickable
            : MaterialStateMouseCursor.textable);
  }

  List<InlineSpan> run(Block? block, int line, Document document,
      {Function? onTap, Function? onHover}) {
    HLTheme theme = HLTheme.instance();

    // Paint paint = Paint()
    // ..color = Colors.blue
    // ..style = PaintingStyle.stroke
    // ..strokeCap = StrokeCap.round
    // ..strokeWidth = 2.0;

    TextStyle defaultStyle = TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: theme.fontSize,
      color: theme.foreground,
      // background: paint
    );

    List<InlineSpan> res = <InlineSpan>[];

    String text = block?.text ?? '';

    bool cache = true;
    if (block?.spans != null) {
      return block?.spans ?? [];
    }

    block?.spans?.clear();
    block?.carets.clear();
    block?.brackets.clear();

    HLLanguage? lang = engine.language(0);

    if (block?.decors == null && text.length < 500) {
      block?.decors = engine.run(block, line, document);
    }
    List<LineDecoration> decors = block?.decors ?? [];

    Map<String, LineDecorator> decorators = block?.document?.decorators ?? {};
    for (final h in decorators.keys) {
      for (final d in (decorators[h]?.run(block) ?? [])) {
        decors.add(d);
      }
    }

    // tabs << convert to decorator
    {
      int indentSize = Document.countIndentSize(text);
      int tabSpaces = (block?.document?.detectedTabSpaces ?? 1);
      if (tabSpaces == 0) tabSpaces = 2;
      int tabStops = indentSize ~/ tabSpaces;
      Color tabStopColor = colorCombine(theme.comment, theme.background, bw: 3);
      for (int i = 0; i <= tabStops; i++) {
        int start = i * tabSpaces;
        int end = start;
        decors.insert(
            0,
            LineDecoration()
              ..start = start
              ..end = end
              ..color = tabStopColor
              ..tab = true);
      }
    }

    text += ' ';
    String prevText = '';
    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      TextStyle style = defaultStyle.copyWith(letterSpacing: 0);

      bool isTabStop = false;

      // decorate
      for (final d in decors) {
        if (i >= d.start && i <= d.end) {
          if (d.tab) {
            if (ch != ' ') continue;
            ch = '│';
            // ch = '|'
            // ch = '︳';
            // ch = '︴';
            // ch = '🭰';
            isTabStop = true;
          }

          if (d.link != '') {
            style = style.copyWith(fontFamilyFallback: [d.link]);
          }

          style = style.copyWith(color: d.color);
          if (d.italic) {
            style = style.copyWith(fontStyle: FontStyle.italic);
          }
          if (d.underline) {
            style = style.copyWith(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: d.color,
                decorationThickness: 1.0);
          }
          if (d.bracket && i == d.start) {
            block?.brackets.add(BlockBracket(
                block: block, position: d.start, open: d.open, bracket: ch));
          }
          if (decorators.length == 0 || isTabStop) {
            break;
          }
        }
      }

      // is within selection
      for (final c in document.cursors) {
        if (c.hasSelection()) {
          Cursor cur = c.normalized();
          int blockLine = cur.block?.line ?? 0;
          int anchorLine = cur.anchorBlock?.line ?? 0;
          if (line > blockLine ||
              (line == blockLine && i + 1 > cur.column) ||
              line < anchorLine ||
              (line == anchorLine && i < cur.anchorColumn)) {
          } else {
            style = style.copyWith(
                backgroundColor: colorCombine(theme.selection, theme.background,
                    aw: 3, bw: 1));
            break;
          }
        }
      }

      // is within caret
      for (final c in document.cursors) {
        if (line == (c.block?.line ?? 0)) {
          int l = (c.block?.text ?? '').length;
          if (i == c.column || (i == l && c.column > l)) {
            Color caretColor = style.color ?? Colors.white;
            if (isTabStop) {
              caretColor = theme.foreground;
            }
            block?.carets.add(BlockCaret(position: i, color: caretColor));
            break;
          }
        }
      }

      if (ch == '\t') {
        ch = String.fromCharCode(0x02192);
        style = style.copyWith(color: theme.comment);
        //' '; // todo! -- properly handle \t ... make files use \t
      }

      if (res.length != 0 && !(res[res.length - 1] is WidgetSpan)) {
        TextSpan prev = res[res.length - 1] as TextSpan;
        if (prev.style == style) {
          prevText += ch;
          res[res.length - 1] = _textSpan(prevText, style, onTap: onTap);
          continue;
        }
      }

      res.add(_textSpan(ch, style, onTap: onTap));
      prevText = ch;
    }

    if (block?.isFolded ?? false) {
      TextStyle moreStyle = defaultStyle.copyWith(
          fontSize: theme.fontSize * 0.8,
          color: theme.string,
          backgroundColor: theme.selection);
      res.add(TextSpan(
          text: '...',
          style: moreStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onTap?.call('unfold:');
            }));
    }

    res.add(CustomWidgetSpan(
        child: Container(height: 1, width: 1), line: line, block: block));

    if (cache) {
      block?.spans = res;
    }

    return res;
  }
}
