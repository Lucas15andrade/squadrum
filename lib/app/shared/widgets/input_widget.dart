import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputWidget extends StatelessWidget {
  TextEditingController _controller;
  String texto;
  var callback;
  int tipo;

  InputWidget(this._controller, this.texto, this.callback, this.tipo);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: tipo == 2 ? true : false,
      controller: _controller,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: tipo == 1
            ? Icon(
                Icons.email,
                color: Colors.white,
              )
            : Icon(
                Icons.lock,
                color: Colors.white,
              ),
        labelText: texto,
        enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0)),
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.white)),
      ),
      validator: callback,
    );
  }
}
