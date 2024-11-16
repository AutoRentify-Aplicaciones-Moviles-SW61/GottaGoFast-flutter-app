import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/widgets/gottagofast_container.dart';

const Color inputColor = Colors.black;

class RoundedInputField extends StatefulWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final Icon icon;
  final TextEditingController controller;

  const RoundedInputField(
      {super.key,
      required this.keyboardType,
      required this.textInputAction,
      required this.hintText,
      required this.icon,
      required this.controller});

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        cursorColor: inputColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: inputColor),
          icon: Icon(
            widget.icon.icon,
            color: inputColor,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: inputColor),
        controller: widget.controller,
      ),
    );
  }
}

class RoundedInputFieldObscure extends StatefulWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final Icon icon;
  final TextEditingController controller;

  RoundedInputFieldObscure({
    Key? key,
    required this.keyboardType,
    required this.textInputAction,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  _RoundedInputFieldObscureState createState() =>
      _RoundedInputFieldObscureState();
}

class _RoundedInputFieldObscureState extends State<RoundedInputFieldObscure> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: obscureText,
        cursorColor: inputColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: inputColor),
          icon: Icon(
            widget.icon.icon,
            color: inputColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: inputColor,
            ),
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: inputColor),
        controller: widget.controller,
      ),
    );
  }
}
