import 'package:flutter/material.dart';
import 'package:myform/src/models/Question.dart';
import 'package:myform/src/widgets/InformationPanel.dart';

class DynamicForm extends StatefulWidget {
  DynamicForm({
    Key? key,
    required this.borderColor,
    required this.borderRadius,
    required this.shadowColor,
    required this.titleLableText,
    required this.titleHintText,
    required this.titleValidationError,
    required this.descriptionLableText,
    required this.descriptionHintText,
    required this.descriptionValidationError,
    required this.selectorText,
    required this.buttonSelectOptionsTypeQuestionText,
    required this.buttonSelectFreeTypeQuestionText,
  }) : super(key: key);

  final Color borderColor;
  final double borderRadius;
  final Color shadowColor;
  final String titleLableText;
  final String titleHintText;
  final String titleValidationError;
  final String descriptionLableText;
  final String descriptionHintText;
  final String descriptionValidationError;
  final String selectorText;
  final String buttonSelectOptionsTypeQuestionText;
  final String buttonSelectFreeTypeQuestionText;

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final formKey = GlobalKey<FormState>();

  String title = "";
  String description = "";
  List<Question> preguntas = [];
  List<Widget> widgetsPreguntas = [];
  String selectedQuestionType = "selector";

  @override
  Widget build(BuildContext context) {
    return form();
  }

  Widget form() {
    return Form(
        key: formKey,
        child: Column(children: <Widget>[
          titleInput(),
          descriptionInput(),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: widgetsPreguntas,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          if (this.selectedQuestionType == "selector") questionTypeSelector(),
          if (this.selectedQuestionType == "options") optionTypeQuestionForm(),
          // if (this.selectedQuestionType == "free")
          // formularioPreguntaLibre(),
        ]));
  }

  Widget titleInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.titleLableText,
        hintText: widget.titleHintText,
        icon: Icon(Icons.title),
      ),
      onChanged: (value) {
        setState(() {
          this.title = value;
        });
      },
      validator: (value) {
        if (value!.length == 0 || value.isEmpty) {
          return widget.titleValidationError;
        }
        return null;
      },
    );
  }

  Widget descriptionInput() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.descriptionLableText,
        hintText: widget.descriptionHintText,
        icon: Icon(Icons.description),
      ),
      onChanged: (value) {
        setState(() {
          this.title = value;
        });
      },
      validator: (value) {
        if (value!.length == 0 || value.isEmpty) {
          return widget.descriptionValidationError;
        }
        return null;
      },
    );
  }

  Widget questionTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor.withOpacity(0.50),
            spreadRadius: 1,
            blurRadius: 9,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              widget.selectorText,
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonSelectOptionsTypeQuestion(),
                buttonSelectFreeAnswerTypeQuestion(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSelectOptionsTypeQuestion() {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              selectedQuestionType = "options";
            });
          }
        },
        child: Text(
          widget.buttonSelectOptionsTypeQuestionText,
          style: TextStyle(fontSize: 16),
        ));
  }

  Widget buttonSelectFreeAnswerTypeQuestion() {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              selectedQuestionType = "free";
            });
          }
        },
        child: Text(
          widget.buttonSelectFreeTypeQuestionText,
          style: TextStyle(fontSize: 16),
        ));
  }

  // TODO:
  // Widget optionTypeQuestionForm() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: widget.borderColor,
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(20)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: widget.shadowColor.withOpacity(0.50),
  //             spreadRadius: 1,
  //             blurRadius: 9,
  //             offset: Offset(0, 4), // changes position of shadow
  //           ),
  //         ]),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         children: [
  //           textoFormularioPreguntaSeleccion(),
  //           Container(
  //             color: Colors.white,
  //             child: Column(
  //               children: widgetsOpcionesPreguntaSeleccion,
  //             ),
  //           ),
  //           if (widgetsOpcionesPreguntaSeleccion.length <= 3)
  //             opcionFormularioPreguntaSeleccion(),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 25.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 botonBorrarPreguntaSeleccion(),
  //                 botonAniadirPreguntaSeleccion(),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // TODO:
  // Widget textoFormularioPreguntaSeleccion() {
  //   return TextFormField(
  //     controller: _controladorPreguntaSeleccion,
  //     keyboardType: TextInputType.multiline,
  //     maxLines: null,
  //     decoration: InputDecoration(
  //       border: UnderlineInputBorder(),
  //       labelText: 'Pregunta',
  //       hintText: 'Escribe una pregunta',
  //       icon: Icon(Icons.question_answer),
  //     ),
  //     onChanged: (value) => setState(() {
  //       textoPreguntaSeleccion = value;
  //     }),
  //     validator: (value) {
  //       if (value!.length == 0 || value.isEmpty) {
  //         return 'Por favor, introduce una pregunta.';
  //       }
  //       return null;
  //     },
  //   );
  // }
}
