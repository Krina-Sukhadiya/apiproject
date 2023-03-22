import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idC = TextEditingController();
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();


  var title = "";
  var decription = "";

  void add() async{
    var url = Uri.parse('http://192.168.29.66:8080/v1/notes');
    var res = await http.post(url,body: jsonEncode({'title': titleC.text, 'description': descriptionC.text}));
    if(res.statusCode == 201){
      print('Data Added');
      print(res.body);
    }else{
      print('Not Added');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Add Data',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
                  child: Column(children: [
                  //   TextFormField(
                  //     controller: idC,
                  //
                  //
                  //     decoration: InputDecoration(
                  //         labelText: 'Id',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         )),
                  //   ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Enter title";
                          }else{
                            return null;
                          }
                        },
                        controller: titleC,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Enter decription";
                          }else{
                            return null;
                          }
                        },
                        controller: descriptionC,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(maximumSize: const Size(100, 60),
                          textStyle: const TextStyle(fontSize: 20),
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                        ),
                        child: const Text('Submit'),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              title = titleC.text;
                              decription = descriptionC.text;
                              Navigator.pop(context);
                              add();
                            });
                          }
                        },
                      ),
                    )
                  ])),
            )));
  }
}
