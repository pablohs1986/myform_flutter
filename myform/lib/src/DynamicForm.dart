import 'package:flutter/material.dart';
import 'package:myform/src/models/Question.dart';
import 'package:myform/src/widgets/InformationPanel.dart';

class DynamicForm extends StatefulWidget {
  DynamicForm({
    Key? key,
    required this.buttonsColor,
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
    required this.optionsTypeQuestionTextLabelText,
    required this.optionsTypeQuestionTextHintText,
    required this.optionTypeQuestionOptionLabelText,
    required this.optionTypeQuestionOptionHintText,
  }) : super(key: key);

  final Color buttonsColor;
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
  final String optionsTypeQuestionTextLabelText;
  final String optionsTypeQuestionTextHintText;
  final String optionTypeQuestionOptionLabelText;
  final String optionTypeQuestionOptionHintText;

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final formKey = GlobalKey<FormState>();
  FocusNode selectorNode = new FocusNode();
  FocusNode questionNode = new FocusNode();
  FocusNode addQuestionNode = new FocusNode();
  // TODO: trabajar con FocusNode() para enfocar al siguiente textfield(al titulo de la pregunta, ya sea libre o tipo opcion)

  String title = "";
  String description = "";
  List<Question> questions = [];
  List<Widget> questionsWidgets = [];
  String selectedQuestionType = "selector";

  var _optionsTypeQuestionFormController = TextEditingController();
  var _optionsTypeQuestionFormOptionsController = TextEditingController();
  String optionTypeQuestionFormText = "";
  String optionTypeQuestionFormOptionText = "";
  List<Widget> optionsTypeQuestionOptionsWidgets = [];
  List<String> optionsTypeQuestionOptionsTexts = [];

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
            color: Colors.transparent,
            child: Column(
              children: questionsWidgets,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          if (this.selectedQuestionType == "selector") questionTypeSelector(),
          if (this.selectedQuestionType == "options") optionsTypeQuestionForm(),
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
        focusNode: selectorNode,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              selectedQuestionType = "options";
              FocusScope.of(context).requestFocus(questionNode);
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
  Widget optionsTypeQuestionForm() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: widget.borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor.withOpacity(0.50),
              spreadRadius: 1,
              blurRadius: 9,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            optionsTypeQuestionFormText(),
            Container(
              color: Colors.white,
              child: Column(
                children: optionsTypeQuestionOptionsWidgets,
              ),
            ),
            if (optionsTypeQuestionOptionsWidgets.length <= 3)
              optionsTypeQuestionFormOption(),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  deleteOptionsTypeQuestionButton(),
                  addOptionsTypeQuestionButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO:
  Widget optionsTypeQuestionFormText() {
    return TextFormField(
      focusNode: questionNode,
      controller: _optionsTypeQuestionFormController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Pregunta',
        hintText: 'Escribe una pregunta',
        icon: Icon(Icons.question_answer),
      ),
      onChanged: (value) => setState(() {
        optionTypeQuestionFormText = value;
      }),
      validator: (value) {
        if (value!.length == 0 || value.isEmpty) {
          return 'Por favor, introduce una pregunta.';
        }
        return null;
      },
    );
  }

  Widget optionsTypeQuestionFormOption() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _optionsTypeQuestionFormOptionsController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Opción',
          hintText: 'Opción',
          icon: null,
          suffixIcon: IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (optionsTypeQuestionOptionsWidgets.length <= 3) {
                  this.optionsTypeQuestionOptionsWidgets.add(
                      optionsTypeQuestionOption(
                          optionTypeQuestionFormOptionText));
                  setState(() {
                    this
                        .optionsTypeQuestionOptionsTexts
                        .add(optionTypeQuestionFormOptionText);
                    this.optionsTypeQuestionOptionsWidgets =
                        optionsTypeQuestionOptionsWidgets;
                    _optionsTypeQuestionFormOptionsController.clear();
                  });
                }
                if (optionsTypeQuestionOptionsWidgets.length == 4) {
                  FocusScope.of(context).requestFocus(addQuestionNode);
                }
              }
            },
            icon: Icon(
              Icons.add,
              color: widget.buttonsColor,
            ),
          ),
        ),
        onChanged: (value) => setState(() {
          optionTypeQuestionFormOptionText = value;
        }),
        validator: (value) {
          if (optionsTypeQuestionOptionsWidgets.length <= 1 &&
              (value!.length == 0 || value.isEmpty)) {
            return 'Por favor, introduce una opción.';
          }
          return null;
        },
      ),
    );
  }

  Widget addOptionsTypeQuestionButton() {
    return ElevatedButton(
      focusNode: addQuestionNode,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (optionsTypeQuestionOptionsWidgets.length > 1) {
            addOptionsTypeQuestion();
            _optionsTypeQuestionFormOptionsController.clear();
            _optionsTypeQuestionFormController.clear();
          }
        }
      },
      child: Icon(
        Icons.done,
        color: optionsTypeQuestionOptionsWidgets.length <= 1
            ? Colors.grey.shade50
            : Colors.blue[50],
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: optionsTypeQuestionOptionsWidgets.length <= 1
            ? Colors.grey
            : widget.buttonsColor, // <-- Button color
        onPrimary: Colors.blueAccent, // <-- Splash color
      ),
    );
  }

  Widget deleteOptionsTypeQuestionButton() {
    return ElevatedButton(
      onPressed: () {
        deleteOptionsTypeQuestion();
      },
      child: Icon(
        Icons.clear,
        color: Colors.red[50],
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.red, // <-- Button color
        onPrimary: Colors.redAccent, // <-- Splash color
      ),
    );
  }

// TODO:
  Widget optionsTypeQuestion(String text, List<Widget> options) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.borderColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            optionsTypeQuestionText(text),
            optionsTypeQuestionOptions(options)
          ],
        ),
      ),
    );
  }

  Widget optionsTypeQuestionText(String text) {
    return TextFormField(
      enabled: false,
      initialValue: text,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.optionsTypeQuestionTextLabelText,
        hintText: widget.optionsTypeQuestionTextHintText,
        icon: Icon(Icons.question_answer),
      ),
    );
  }

  Widget optionsTypeQuestionOptions(List<Widget> options) {
    return Column(children: options);
  }

  Widget optionsTypeQuestionOption(String text) {
    return TextFormField(
      enabled: false,
      initialValue: text,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.optionTypeQuestionOptionLabelText,
        hintText: widget.optionTypeQuestionOptionHintText,
        icon: null,
      ),
    );
  }

  // Logic //
  // TODO:
  void addOptionsTypeQuestion() {
    this.questionsWidgets.add(optionsTypeQuestion(
        optionTypeQuestionFormText, optionsTypeQuestionOptionsWidgets));

    Question question = new Question(
        type: 1,
        text: optionTypeQuestionFormOptionText,
        answerType: '',
        options: optionsTypeQuestionOptionsTexts);
    this.questions.add(question);

    setState(() {
      this.questionsWidgets = questionsWidgets;
      optionsTypeQuestionOptionsWidgets = [];
      optionsTypeQuestionOptionsTexts = [];
      selectedQuestionType = "selector";
      FocusScope.of(context).requestFocus(selectorNode);
    });
  }

  // TODO:
  void deleteOptionsTypeQuestion() {
    _optionsTypeQuestionFormOptionsController.clear();
    _optionsTypeQuestionFormController.clear();
    setState(() {
      optionsTypeQuestionOptionsWidgets = [];
      optionsTypeQuestionOptionsTexts = [];
      selectedQuestionType = "selector";
    });
  }
}
