import 'dart:convert';
import 'package:apiproject/Add.dart';
import 'package:apiproject/Edit.dart';
import 'package:apiproject/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Modeldata> modeldata = [];
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Add())).then((value) => setState((){}));
          // setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('API'),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: modeldata.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.lightGreen,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Id: ${modeldata[index].id}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Title: ${modeldata[index].title}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Description: ${modeldata[index].description}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(children: [
                            IconButton(onPressed: (){
                              Delete(modeldata[index].id);
                              setState(() {
                              });
                            }, icon: const Icon(Icons.delete)
                            ),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(modeldata: snapshot.data![index],),
                                fullscreenDialog: true,
                              ));
                              // Delete(modeldata[index].id);
                              setState(() {
                              });
                            }, icon: const Icon(Icons.edit)
                            ),
                          ],),

                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<Modeldata>> getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.29.66:8080/v1/notes'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
    final list = data as List;
    modeldata = list.map((e) => Modeldata.fromJson(e)).toList();

      return modeldata;
    } else {
      return modeldata;
    }
  }

  // Future<void> _editDialog(
  //     Modeldata notesModel, String title, String description) async {
  //   titleC.text = title;
  //   descriptionC.text = description;
  //
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Edit'),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   controller: titleC,
  //                   decoration: const InputDecoration(
  //                       labelText: 'Enter Name', border: OutlineInputBorder()),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 TextFormField(
  //                   controller: descriptionC,
  //                   decoration: const InputDecoration(
  //                       labelText: 'Enter Description',
  //                       border: OutlineInputBorder()),
  //                 )
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Cancel')),
  //             TextButton(
  //                 onPressed: () {
  //                   notesModel.title = titleC.text.toString();
  //                   notesModel.description = descriptionC.text.toString();
  //                   // notesModel.save();
  //                   Navigator.pop(context);
  //                   titleC.clear();
  //                   descriptionC.clear();
  //                 },
  //                 child: const Text('Edit'))
  //           ],
  //         );
  //       });
  // }
  
  void Delete(String id) async{
    var url = Uri.parse('http://192.168.29.226:8080/v1/notes/$id');
    var response = await http.delete(url);
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$id')));
    }
  }
  //
  // void add() async{
  //   var url = Uri.parse('http://192.168.29.8:8080/v1/notes');
  //   var res = await http.post(url,body: jsonEncode({'title': 'Krina', 'description': 'Pacific School Of Engineering'}));
  //   if(res.statusCode == 201){
  //     print('Data Added');
  //     print(res.body);
  //   }else{
  //     print('Not Added');
  //   }
  // }
}
