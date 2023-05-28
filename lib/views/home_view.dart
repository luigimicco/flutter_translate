import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../models/language_model.dart';
import '../helpers/mlkit.dart';
import '../widgets/bubble_widget.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController textController = TextEditingController();
  late bool waiting = false;
  final List<ItemModel> items = [];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: SafeArea(
            child: Column(children: [
              Flexible(
                  child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Bubble(
                      message: items[index].text, type: items[index].type);
                },
              )),
              if (waiting) const Text("waiting ..."),
              const Divider(
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onSubmitted: (value) => analyzeText(),
                        decoration: const InputDecoration.collapsed(
                            hintText: "digitare il testo qui ..."),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_sharp),
                      onPressed: () {
                        analyzeText();
                      },
                    ),
                  ],
                ),
              )
            ]),
          )),
    );
  }

  void analyzeText() {
    if (textController.text.isEmpty) return;

    waiting = true;
    String text = textController.text;

    items.insert(
        0,
        ItemModel(
          text: text,
          type: "text",
        ));
    textController.clear();
    setState(() {});

    MLHelper helper = MLHelper();
    helper.identifyLanguage(text).then((result) {
      List<String> text = [];
      for (LanguageModel language in result) {
        text.add(
            '${language.text.toUpperCase()} (${(language.confidence * 100).toStringAsFixed(1)}%)');
      }

      items.insert(
          0,
          ItemModel(
            text: text.join(","),
            type: "language",
          ));
      setState(() {
        waiting = false;
      });
    });
  }
}
