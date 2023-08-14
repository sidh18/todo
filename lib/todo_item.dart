import 'package:flutter/material.dart';

import './todo.dart';
import 'colors.dart';

class ToDoitem extends StatelessWidget{
    final ToDo todo;
    final onToDoChanged;
    final onDeleteitem;

    const ToDoitem({
      Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteitem,
    }):super(key: key);
@override
Widget build(BuildContext context){
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child:ListTile(
      onTap:(){
        onToDoChanged(todo);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      tileColor: Colors.white,
      leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color:blue,
        ),
        title: Text(
          todo.todotext!,
          style: TextStyle(
            fontSize: 16,
            color: black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteitem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
      