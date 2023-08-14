import 'package:flutter/material.dart';
import './todo.dart';
import './colors.dart';
import './todo_item.dart';

class Home extends StatefulWidget{
  Home({Key? key}):super(key:key);

  @override
  State<Home> createState()=>_Homestate();
}

class _Homestate extends State<Home>{
  final todoList = ToDo.todolist();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
    void initState() {
    _foundToDo=todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: _buildAppBar(),
      body:Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child:ListView(
                    children: [
                      Container(
                        margin:EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoitem(
                          todo:todoo,
                          onToDoChanged:_handleToDoChange,
                          onDeleteitem:_deleteToDoitem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20,left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:const[
                      BoxShadow(
                        color:Colors.grey,
                        offset:Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    ),
                    child:TextField(
                      controller:_todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new ToDO item',
                        border:InputBorder.none,
                      ),
                    ),
                  ),
                
                ),
                Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child:ElevatedButton(
                      child:Text('+',style: TextStyle(fontSize: 40),),
                      onPressed: (){
                        _addToDoitem(_todoController.text);
                      },
                      style:ElevatedButton.styleFrom(
                        primary: blue,
                        minimumSize: Size(60,60),
                        elevation: 10,
                      ),
                    ),
                  ),
               ]),
              ),
            ]),
          );
     }

void _handleToDoChange(ToDo todo){
  setState(() {
    todo.isDone=!todo.isDone;
  });
}
void _deleteToDoitem(String id){
  setState(() {
    todoList.removeWhere((item) => item.id ==id);
  });
}

void _addToDoitem(String todo){
  setState(() {
    todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todotext: todo));
  });
  _todoController.clear();
}

void _runfilter(String enteredkeyword){
  List<ToDo>results =[];
  if(enteredkeyword.isEmpty){
    results=todoList;}
    else{
      results=todoList.where((item) => item.todotext!.toLowerCase().contains(enteredkeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo=results;
    });
}

Widget searchBox(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      onChanged: (value)=>_runfilter(value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          color:black,
          size:20,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color:grey),
      ),
    ),
  );
}

AppBar _buildAppBar(){
  return AppBar(
    backgroundColor: bgcolor,
    elevation: 0,
    title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Icon(
      Icons.menu,
      color:black,
      size:30,
    ),
    Container(
      height: 40,
      width: 40,
      child: ClipRRect(borderRadius: BorderRadius.circular(20),
      ),
    ),
  ]),
  );
}
}


