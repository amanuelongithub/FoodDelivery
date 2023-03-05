import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  DefaultTextField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return TextFormField(
      controller: textEditingController,
      showCursor: true,
      cursorColor: Color.fromARGB(151, 102, 78, 4),
      enableInteractiveSelection: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color.fromARGB(255, 126, 126, 126),
            fontWeight: FontWeight.bold),
        border: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 126, 126, 126), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
