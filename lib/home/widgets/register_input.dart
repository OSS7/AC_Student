import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ac_students/data/constant.dart';

enum inputType { password, normal }

enum inputSize { big, small }

class RegisterInput extends StatefulWidget {
  final String? hntText;
  final inputType? type;
  inputSize? size = inputSize.big;
  int? maxLength ;
  final FormFieldValidator<String>? validate;
  TextEditingController? control;
  RegisterInput(
      {Key? key,
      this.hntText,
      this.type,
      this.maxLength,
      this.control,
      this.validate,
      this.size})
      : super(key: key);

  @override
  State<RegisterInput> createState() => _RegisterInputState();
}

class _RegisterInputState extends State<RegisterInput> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        width: widget.size == inputSize.small
            ? size.width * 0.4
            : size.width * 0.9,
        // height: size.height  * 0.08,
        child: TextField(
          
          maxLines: widget.maxLength ??1,
          controller: widget.control,
          obscureText: widget.type == inputType.password ? true : false,
          style: TextStyle(fontSize: 14, color: secondaryClr),
          cursorColor: secondaryClr,
          decoration: InputDecoration(
            labelText: widget.hntText,
            labelStyle: TextStyle(fontSize: 12, color: secondaryClr),
            hintStyle: TextStyle(color: secondaryClr),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryClr, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: secondaryClr, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
