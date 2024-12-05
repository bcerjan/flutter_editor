import 'package:editor/services/ui/modal.dart';
import 'package:editor/services/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorModal extends StatelessWidget {
  const ErrorModal({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final ui = Provider.of<UIProvider>(context, listen: false);
    final List<UIButton> btns = [
      UIButton(
        text: 'Dismiss',
        onTap: () => ui.clearPopups(),
      ),
    ];
    return UIModal(
      title: 'Error: ',
      message: text,
      buttons: btns,
      width: 400,
    );
  }
}
