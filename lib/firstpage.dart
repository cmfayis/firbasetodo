import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfire/add.dart';
import 'package:flutter/material.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  final students = FirebaseFirestore.instance.collection('student');
  void delete(docid){
    students.doc(docid).delete();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO APP'),
          backgroundColor: Color.fromARGB(255, 8, 45, 72),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Homescreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Color.fromARGB(255, 8, 45, 72),
        ),
        body: StreamBuilder(
          stream: students.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final studentData = snapshot.data.docs[index];
                  return Card(
                    color: Color.fromARGB(255, 153, 191, 199),
                    child: ListTile(
                      title: Text(
                        studentData['name'],
                      ),
                      subtitle: Text(
                        studentData['age'],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/update',
                                arguments: {
                                  'name': studentData['name'],
                                  'age': studentData['age'],
                                  'id': studentData.id,
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              delete(studentData.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
