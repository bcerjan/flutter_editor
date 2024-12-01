import 'package:editor/services/ui/modal.dart';
import 'package:flutter/material.dart';

class ErrorModal extends StatelessWidget {
  const ErrorModal({super.key, required this.text});
  final String text;
  static const List<UIButton> btns = [
    UIButton(
      text: 'Dismiss',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return UIModal(
      title: 'Error: ',
      message: text,
      buttons: btns,
      width: 400,
    );
  }
}
