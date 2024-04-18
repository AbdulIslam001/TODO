
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Component/CustomButton.dart';
import 'package:todo_app/Model/Task.dart';
import 'package:todo_app/Resources/CustomSize.dart';
import 'package:todo_app/Services/DatabaseHandler.dart';
import 'package:todo_app/Utils/FlushBar.dart';

import '../Component/CustomContainer.dart';
import 'AddTask.dart';
import 'ToDoTaskScreen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  final TextEditingController _date=TextEditingController();
  final TextEditingController _title=TextEditingController();

  bool isClicked=false;
  List<String> itemlist=["Work","Personal","Learning","Shopping"];
  String selectedValue="Personal";

  int imp=0;
  int toDays=0;
  int upcoming=0;
  int personal=0;
  int work=0;
  int shopping=0;
  int learning=0;


  Future<void> getTasks()async{
    List<Task> tasks=await DatabaseHandler().getTask();
    String date="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    for(int i=0;i<tasks.length;i++){
      List<String> dmy=tasks[i].date.split("/");
      int day=int.parse(dmy[0]);
      int month=int.parse(dmy[1]);
      int year=int.parse(dmy[2]);

      if(tasks[i].isImportant=="1"){
        imp++;
      }else if(year>=int.parse(DateTime.now().year.toString())&&month>=int.parse(DateTime.now().month.toString())&&day>=int.parse(DateTime.now().day.toString())){
        upcoming++;
      }else if(tasks[i].date==date){
        toDays++;
      }else if(tasks[i].type=="Personal"){
        personal++;
      }else if(tasks[i].type=="Work"){
        work++;
      }else if(tasks[i].type=="Learning"){
        learning++;
      }else if(tasks[i].type=="Shopping"){
        shopping++;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future:getTasks(),
          builder: (context, snapshot) {
          return Padding(
            padding:EdgeInsets.only(top: CustomSize().customHeight(context)/10),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: CustomSize().customHeight(context)/50),
                      child: const Text("Lists",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(CustomSize().customWidth(context)/40),
                      child: Container(
                        width: CustomSize().customWidth(context)/1.8,
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.search),
                              labelText: "Search",
                              hintText: "Search",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: CustomSize().customHeight(context)/50),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: CustomSize().customHeight(context) / 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(CustomSize().customHeight(context) / 30),
                            child: Image.asset("Assets/boy.jpeg"),
                          ),
                        )
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(CustomSize().customHeight(context)/35),
                  child: Container(
                    width: CustomSize().customWidth(context)/1,
                    height: CustomSize().customHeight(context)/4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(CustomSize().customHeight(context)/60),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sunny),
                              SizedBox(
                                width:CustomSize().customWidth(context)/20 ,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ToDoTaskScreen(title: "My Day",);
                                        },));
                                      },
                                      child: const Text("My Days",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15))),
                                  Text(toDays.toString(),style: TextStyle(color: Colors.grey.withOpacity(0.4),fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height:CustomSize().customHeight(context)/40 ,
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(
                                width:CustomSize().customWidth(context)/20 ,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ToDoTaskScreen(title: "Upcoming",);
                                        },));
                                      },
                                      child: const Text("Up coming",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15))),
                                  Text(upcoming.toString(),style: TextStyle(color: Colors.grey.withOpacity(0.4),fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height:CustomSize().customHeight(context)/40 ,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star),
                              SizedBox(
                                width:CustomSize().customWidth(context)/20 ,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ToDoTaskScreen(title: "Important",);
                                        },));
                                      },
                                      child: const Text("Important",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15))),
                                  Text(imp.toString(),style: TextStyle(color: Colors.grey.withOpacity(0.4),fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomContainer(color: Colors.blue.shade400,title: "Personal",icon: Icons.person,leftTask: personal.toString()),

                    CustomContainer(color: Colors.purple.shade200,title: "Learning",icon: Icons.book_sharp,leftTask: learning.toString()),
                  ],
                ),
                SizedBox(
                  height: CustomSize().customHeight(context)/30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomContainer(color: Colors.blueGrey.withOpacity(0.5),title: "Work",icon: Icons.work,leftTask: work.toString()),
                    CustomContainer(color: Colors.red.shade400,title: "Shopping",icon: Icons.shopping_basket,leftTask: shopping.toString()),
                  ],
                ),
              ],
            ),
          );
        },)
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey.shade400,
          onPressed: (){
            showDialog(
              context: context, builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState)
                {
                  return AlertDialog(
                    title: Padding(
                      padding: EdgeInsets.all(CustomSize().customHeight(context)/20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Is Important",style: TextStyle(fontSize: 15)),
                              GestureDetector(
                                  onTap: (){
                                    isClicked=!isClicked;
                                    setState((){});
                                  },
                                  child: Icon(isClicked?Icons.star:Icons.star_border)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(CustomSize().customWidth(context)/40),
                            child: TextFormField(
                              controller: _title,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Title",
                                  hintText: "Title",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    //  borderSide: BorderSide.none
                                  )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                              ).then((value) {
                                _date.text="${value!.year}/${value!.month}/${value!.day}";
                                setState(() {});
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(CustomSize().customWidth(context)/40),
                              child:Container(
                                height: 61,
                                width: 265,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(),
                                    color: Colors.white
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child:Text(_date.text,style: TextStyle(fontSize: 15)),
                                      ),
                                      const Icon(Icons.calendar_month)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text("Category"),
                          DropdownButton(
                            value: selectedValue,
                            items: itemlist.map((e) {
                              return DropdownMenuItem(
                                  value: e.toString(),
                                  child: Text(e.toString()));
                            }).toList(), onChanged: (value) {
                            selectedValue=value.toString();
                            setState(() {});
                          },),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(title: "Add", loading: false,onTap: ()async{
                                String important="0";
                                isClicked?important="1":important="0";
                                Task t = Task(status: "1",
                                    type: selectedValue,
                                    title: _title.text.toString(),
                                    date: _date.text.toString(),
                                    endTime: "endTime", isImportant: important,
                                    startTime: "startTime");
                                int status=await DatabaseHandler().addTask(t);
                                if(status>=1&& context.mounted){
                                  Navigator.pop(context);
                                  setState((){});
                                }else if(context.mounted){
                                  Utilis.flushBarMessage("Error", context);
                                }
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                    scrollable: true,
                  );
                },
              );
            },);
            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddTask();
            },));*/
          },child: const Center(
        child: Icon(Icons.add,color: Colors.white),
      )),
    );
  }
}

