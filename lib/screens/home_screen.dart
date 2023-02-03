import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context,index){
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoList[index]["title"],style:const TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(todoList[index]["description"],style:const TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            todoList.removeAt(index);
                            setState(() {

                            });
                          }, icon:const Icon(Icons.delete)),
                          IconButton(onPressed: (){
                            String title = todoList[index]["title"];
                            String description = todoList[index]["title"];
                            _editItemDialog(index,title,description);
                          }, icon:const Icon(Icons.edit_outlined))
                        ],
                      )

                    ],
                  )
                ]
              ),
            ),
          );
        },
      ),



      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const[
            Text("Add Todo"),
            Icon(Icons.add)
          ],
        ),
        onPressed: (){
          _addItemDialog();
        },
      ),
    );
  }


  Future<void> _addItemDialog()async{
    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: Text('Add Notes'),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText:  'Enter Title',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder()
                    ),
                  )
                ],
              )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            } ,
              child: Text('Cancel'),
            ),
            TextButton(onPressed: (){

              todoList.add({"title":titleController.text,"description":descriptionController.text});
              titleController.clear();
              descriptionController.clear();
              setState(() {

              });
              Navigator.pop(context);
            } ,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editItemDialog(int index,String title,String description)async{
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: const Text('Add Task'),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText:  'Enter Title',
                        border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder()
                    ),
                  )
                ],
              )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            } ,
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: (){
              todoList[index] = {"title":titleController.text,"description":descriptionController.text};
              setState(() {

              });
              titleController.clear();
              descriptionController.clear();

              Navigator.pop(context);
            } ,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
