import 'dart:convert';
import 'package:apiproject/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  Modeldata modeldata;

   Edit(
      {super.key, required this.modeldata});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleC = TextEditingController(text: widget.modeldata.title);
  late TextEditingController descriptionC =
      TextEditingController(text: widget.modeldata.description);

  @override

  void edit() async {
    var url =
        Uri.parse('http://192.168.29.66:8080/v1/notes/${widget.modeldata.id}');
    var res = await http.put(url,
        body: jsonEncode(
            {"title": titleC.text, "description": descriptionC.text}));
    if (res.statusCode == 200) {
      print('Data Added Successfully');
      print(res.body);
    } else {
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
            'Edit Data',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter title";
                      } else {
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter decription";
                      } else {
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
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(100, 60),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        edit();
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ])),
        )));
  }
}
