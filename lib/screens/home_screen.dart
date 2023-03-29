import 'package:flutter/material.dart';
import 'package:todoappwithstatefullwidget/screens/details_screen.dart';

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

          return InkWell(
            focusColor: Colors.transparent,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(title: todoList[index]["title"], description: todoList[index]["description"])));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoList[index]["title"],
                      style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                                todoList[index]["description"],
                                style:const TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              todoList.removeAt(index);
                              setState(() {

                              });
                            }, icon:const Icon(Icons.delete)),
                            IconButton(onPressed: (){
                              String title = todoList[index]["title"];
                              String description = todoList[index]["description"];
                              _editItemDialog(index,title,description);
                            }, icon:const Icon(Icons.edit_outlined))
                          ],
                        )

                      ],
                    )
                  ]
                ),
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
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: Text('Add Notes'),
          content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          hintText:  'Enter Title',
                          border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title is empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title is empty';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
            } ,
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: (){
            if (_formKey.currentState!.validate()) {
                todoList.add({"title":titleController.text,"description":descriptionController.text});
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              }
              setState(() {

              });

            } ,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editItemDialog(int index,String title,String description)async{

    final _formkey = GlobalKey<FormState>();
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: const Text('Add Task'),
          content: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          hintText:  'Enter Title',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Title is empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder()
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Description is empty';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
            } ,
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: (){
              if(_formkey.currentState!.validate()){
                todoList[index] = {"title":titleController.text,"description":descriptionController.text};
                setState(() {

                });
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              }

            } ,
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
