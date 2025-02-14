import 'package:flutter/material.dart';

class DecryptForm extends StatelessWidget {
  const DecryptForm({super.key, required this.cipherController, required this.keyController,});

  final TextEditingController cipherController;
  final TextEditingController keyController;

  Widget _textField({
    BoxConstraints? constraint,
    String? hint,
    int? minLines,
    int? maxLines,
    required TextEditingController controller,
  }) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        constraints: constraint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _textField(controller: cipherController, hint: "Cipher Text"),
      SizedBox(height: 5,),
      _textField(controller: keyController, hint: "Key"),
    ],);
  }
}
