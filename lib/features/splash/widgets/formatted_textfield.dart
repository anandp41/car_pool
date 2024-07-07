import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormattedTextFormField extends StatefulWidget {
  @override
  _CustomFormattedTextFormFieldState createState() =>
      _CustomFormattedTextFormFieldState();
}

class _CustomFormattedTextFormFieldState
    extends State<CustomFormattedTextFormField> {
  // final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  String _formatNumber(String number) {
    String digitsOnly = number.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 4 || i == 7) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          String newText = _formatNumber(newValue.text);
          return newValue.copyWith(
            text: newText,
            selection: TextSelection.fromPosition(
              TextPosition(offset: newText.length),
            ),
          );
        }),
      ],
      decoration: const InputDecoration(
        labelText: 'Enter 10-digit number',
        border: OutlineInputBorder(),
      ),
    );
  }
}
