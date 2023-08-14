class ToDo{
  String?id;
  String?todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone=false,
  });

  static List<ToDo>todolist(){
    return[
      ToDo(id:'01',todotext:'Morning exercise',isDone:true),
    ];
  }
}
