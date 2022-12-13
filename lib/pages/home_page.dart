import 'package:flutter/material.dart';
import 'package:todoapp/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();

  //list of tasks
  List toDoList = [
    ["make tutorial",false],
    ["Do exercise",false],
  ];

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask(){
    setState((){
      toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
  }

  //create new task
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel:() => Navigator.of(context).pop(),);
    }
    );
    // reset the text field
    _controller.text = "";
    
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
    // reset the text field
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text('TO DO')),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),            
          );
        },
      ),
    );
  }
}
