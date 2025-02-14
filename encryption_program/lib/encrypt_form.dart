import 'package:encryption_program/encrypt_decrypt.dart';
import 'package:flutter/material.dart';

class EncryptForm extends StatelessWidget {
  const EncryptForm({
    super.key,
    required this.plainTextCntrl,
    required this.keyCntrl,
  });

  final TextEditingController keyCntrl;
  final TextEditingController plainTextCntrl;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _textField(
            hint: "Plain Text",
            minLines: 2,
            maxLines: 5,
            controller: plainTextCntrl),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            _textField(
                constraint: const BoxConstraints(maxWidth: 135),
                hint: "key",
                controller: keyCntrl),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () {
                // Generate key
                keyCntrl.text = generateRandomKey(7);
              },
              child: const Text("Generate Key"),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
