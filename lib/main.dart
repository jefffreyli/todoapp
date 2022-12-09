import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

List isChecked = <bool>[];
List<String> tasks = <String>[];
List descriptions = <String>[];
List deadlines = <String>[];

final TextEditingController _textFieldController1 = TextEditingController();
final TextEditingController _textFieldController2 = TextEditingController();
final TextEditingController _textFieldController3 = TextEditingController();

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Tasks'), backgroundColor: Color(0xff93BBF6)),
      body: ListView(children: getItems()),
      backgroundColor: Color.fromARGB(255, 236, 239, 249),
      // add items to the to-do list
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add),
          backgroundColor: Color(0xff93BBF6)),
    );
  }

  void addTodoItem(String task, String description, String deadline) {
    setState(() {
      tasks.add(task);
      descriptions.add(description);
      deadlines.add(deadline);
      isChecked.add(false);
    });
    _textFieldController1.clear();
    _textFieldController2.clear();
    _textFieldController3.clear();
  }

  // this Generate list of item widgets
  Widget buildTodoItem(String task, String deadline, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage(index)),
          ).then((value) => setState(() {}));
        },
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(children: <Widget>[
              ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked[index] = value!;
                        //   tasks.removeAt(index);
                        //   descriptions.removeAt(index);
                        //   deadlines.removeAt(index);
                      });
                    },
                    value: isChecked[index],
                  ),
                  title: Text(task),
                  subtitle: Text(deadline),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                        descriptions.removeAt(index);
                        deadlines.removeAt(index);
                        isChecked.removeAt(index);
                      });
                    },
                  ))
            ])));
  }

  // display a dialog for the user to enter items
  Future<Future> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: const Text('Add a task to your list'),
            content: Column(children: [
              TextField(
                controller: _textFieldController1,
                decoration: const InputDecoration(hintText: 'Task'),
              ),
              TextField(
                controller: _textFieldController2,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              TextField(
                controller: _textFieldController3,
                decoration: const InputDecoration(hintText: 'Deadline'),
              ),
            ]),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  addTodoItem(_textFieldController1.text,
                      _textFieldController2.text, _textFieldController3.text);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // iterates through our todo list title
  List<Widget> getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (int i = 0; i < tasks.length; i++) {
      todoWidgets.add(buildTodoItem(tasks[i], deadlines[i], i));
    }
    return todoWidgets;
  }
}

//descriptionPage

class descriptionPage extends StatefulWidget {
  final int index;
  const descriptionPage(this.index);

  @override
  State<descriptionPage> createState() => _descriptionPageState();
}

class _descriptionPageState extends State<descriptionPage> {
  void editTodoItem(
      String task, String description, String deadline, int index) {
    setState(() {
      tasks[index] = task;
      descriptions[index] = description;
      deadlines[index] = deadline;
    });
    _textFieldController1.clear();
    _textFieldController2.clear();
    _textFieldController3.clear();
  }

  Future<Future> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    _textFieldController1.text = tasks[widget.index];
    _textFieldController2.text = descriptions[widget.index];
    _textFieldController3.text = deadlines[widget.index];

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: const Text('Edit task'),
            content: Column(children: [
              TextField(
                controller: _textFieldController1,
                decoration: const InputDecoration(hintText: 'Task'),
              ),
              TextField(
                controller: _textFieldController2,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              TextField(
                controller: _textFieldController3,
                decoration: const InputDecoration(hintText: 'Deadline'),
              ),
            ]),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  Navigator.of(context).pop();
                  editTodoItem(
                      _textFieldController1.text,
                      _textFieldController2.text,
                      _textFieldController3.text,
                      widget.index);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(backgroundColor: Color(0xff93BBF6));
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff93BBF6)),
      backgroundColor: Color(0xffF6F8FE),
      body: Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height),
        width: MediaQuery.of(context).size.width / 1.05,
        margin: EdgeInsets.all(15),
        child: Container(
            child: Card(
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tasks[widget.index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                )),
                            Text("Due: ${deadlines[widget.index]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.grey)),
                          ],
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        Text(descriptions[widget.index].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6),
                      ],
                    )))),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Edit Item',
          child: Icon(Icons.edit),
          backgroundColor: Color.fromARGB(255, 223, 182, 17)),
    );
  }
}
