import 'package:flutter/material.dart';

class FromCondainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labeltext;
  final String? helperText;
  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FromCondainerWidget(
      {super.key,
      this.onChanged,
      this.controller,
      this.fieldkey,
      this.isPasswordField,
      this.hintText,
      this.labeltext,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  State<FromCondainerWidget> createState() => _FromCondainerWidgetState();
}

class _FromCondainerWidgetState extends State<FromCondainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        // height: 50,
        width: double.infinity,

        child: TextFormField(
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldkey,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 124, 206),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 92, 92, 92),
                  width: 0.5,
                ),
              ),
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: widget.isPasswordField == true
                    ? Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: _obscureText == false
                            ? const Color.fromARGB(206, 243, 33, 33)
                            : Colors.grey,
                      )
                    : const Text(' '),
              )),
        ),
      ),
    );
  }
}
