import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final Function(String) validator;

  const RoundedInput({Key key, this.name, this.validator, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: name,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.indigo[900], width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.indigo[900], width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue[900], width: 2),
          ),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
