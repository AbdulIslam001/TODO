

import 'package:flutter/material.dart';
import 'package:todo_app/Resources/CustomSize.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _date=TextEditingController();

  List<String> itemlist=["Work","Personal","Learning","Shopping"];
  String selectedValue="Personal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Add Task"),),
      body: Padding(
        padding: EdgeInsets.all(CustomSize().customHeight(context)/20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(CustomSize().customWidth(context)/40),
              child: TextFormField(
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
                            child:Text(_date.text),
                          ),
                          const Icon(Icons.calendar_month)
                        ],
                      ),
                    ),
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
              ],
            ),

          ],
        ),
      ),
    );
  }
}
