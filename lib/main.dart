import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> todoList = ["homework", "todo1"];
  final _formKey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Delete All Tasks"),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            todoList.clear();
          });
        },
      ),
      appBar: AppBar(
        title: const Text("To do list"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Flex(direction: Axis.vertical, children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: myController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Write the todo text";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              todoList = [
                                ...todoList,
                                myController.value.text.toString()
                              ];
                            });
                            myController.value =
                                const TextEditingValue(text: "");
                          }
                        },
                        child: const Text("Submit")),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: todoList.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(todoList[index]),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.remove(todoList[index]);
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: const Text("Delete"),
                    )
                  ],
                ),
              ),
            )
          ])),
    ));
  }
}
