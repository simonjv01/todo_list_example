import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TodoList()));

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _items = [];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index] = _items[index].startsWith('✓')
          ? _items[index].substring(2)
          : '✓ ' + _items[index];
    });
  }

  void _displayDialog() async {
    final textController = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add new item'),
              content: TextField(controller: textController),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (textController.text.isNotEmpty) {
                        _addItem(textController.text);
                      }
                    },
                    child: Text('OK')),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) => ListTile(
                onTap: () => _toggleItem(index),
                title: Text(_items[index]),
              )),
      floatingActionButton: FloatingActionButton(
          onPressed: _displayDialog, child: Icon(Icons.add)),
    );
  }
}
