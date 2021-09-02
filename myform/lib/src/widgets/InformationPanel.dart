import 'package:flutter/material.dart';

class InformationPanel extends StatefulWidget {
  InformationPanel({Key? key, required this.texto, required this.color})
      : super(key: key);

  String texto;
  Color color;

  @override
  _InformationPanelState createState() => _InformationPanelState();
}

class _InformationPanelState extends State<InformationPanel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      style: TextStyle(fontSize: 15, color: widget.color),
    );
  }
}
