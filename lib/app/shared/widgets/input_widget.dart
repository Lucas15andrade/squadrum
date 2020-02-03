import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  TextEditingController _controller;
  String texto;
  var callback;
  int tipo;
  Icon icone;
  var onChange;
  Color cor;

  InputWidget(this._controller, this.texto, this.callback, this.tipo,
      this.icone, this.onChange,
      {this.cor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: tipo == 2 ? true : false,
      controller: _controller,
      style: TextStyle(color: cor != null ? cor : Colors.white, fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: icone,
        labelText: texto,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: cor != null ? cor : Colors.white, width: 2.0)),
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: cor != null ? cor : Colors.white),
        labelStyle: TextStyle(color: cor != null ? cor : Colors.white),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: cor != null ? cor : Colors.white, width: 2.0)),
      ),
      validator: callback,
      onChanged: onChange,
    );
  }
}
