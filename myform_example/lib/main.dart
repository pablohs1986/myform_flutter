import 'package:flutter/material.dart';
import 'package:myform/myform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myForm Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'myForm Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: DynamicForm(
          borderColor: Colors.purple,
          borderRadius: 7.5,
          shadowColor: Colors.grey,
          titleHintText: 'Title',
          titleLableText: 'Title',
          titleValidationError: 'Please, enter a title',
          descriptionHintText: 'Description',
          descriptionLableText: 'Description',
          descriptionValidationError: 'Please, enter a description',
          buttonSelectFreeTypeQuestionText: 'Free',
          buttonSelectOptionsTypeQuestionText: 'Options',
          selectorText: 'Select a question type',
        ),
      ),
    );
  }
}
