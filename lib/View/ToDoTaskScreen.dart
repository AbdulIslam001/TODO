import 'package:flutter/material.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Resources/CustomSize.dart';
import 'package:todo_app/Services/DatabaseHandler.dart';

class ToDoTaskScreen extends StatefulWidget {
  String title;
  ToDoTaskScreen({super.key, required this.title});

  @override
  State<ToDoTaskScreen> createState() => _ToDoTaskScreenState();
}


class _ToDoTaskScreenState extends State<ToDoTaskScreen> {
  bool isChecked = false;
  List<String> days=["M","T","W","T","F","S","S"];
  int i=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        centerTitle: true,
        title: Text(widget.title),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.table_chart),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: CustomSize().customHeight(context) / 20),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("${DateTime.now().month}/${DateTime.now().year}"),
                ),
                GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      isChecked = !isChecked;
                      setState(() {});
                    },
                    child: Icon(isChecked
                        ? Icons.arrow_drop_down_outlined
                        : Icons.arrow_drop_up_outlined),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isChecked,
              child: SizedBox(
                height: 61,
                child: Column(
                  children: [
                    Expanded(
                        child:ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            i++;
                            i%7==0?i=0:i=i;
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 40,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(days[i]),
                                  Text((index+1).toString())
                                ],
                              ),
                            ),
                          );
                        },)
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: DatabaseHandler().getTask(),
                  builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: 100,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapshot.data![index].title,style: TextStyle(color: Colors.blue,fontSize: 25)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: snapshot.data![index].type=="Work"?
                                        Colors.black:snapshot.data![index].type=="Personal"?
                                        Colors.blue:snapshot.data![index].type=="Shopping"?
                                            Colors.deepPurple:Colors.red,
                                      ),
                                      Text(snapshot.data![index].type),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        DatabaseHandler().deleteTask(snapshot.data![index].id!);
                                        setState(() {

                                        });
                                      },
                                      child: const Icon(Icons.delete,color: Colors.blue)),
                                  Icon(snapshot.data![index].isImportant=="1"?Icons.star:Icons.star_border,color: Colors.blue,),
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                    );
                  },);
              }else{
                return const Row(
                  children: [
                    Center(
                        child: CircularProgressIndicator()),
                  ],
                );
              }
            },))
          ],
        ),
      ),
    );
  }
}
