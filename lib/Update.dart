import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({
    super.key,
  });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('student');
  void upDatedata(studentId) {
    final DATA = {
      'name': namecontroller.text,
      'age': agecontroller.text,
    };
    userdata.doc(studentId).update(DATA).then((value) =>Navigator.pop(context) ,);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    namecontroller.text = args['name'];
    agecontroller.text = args['age'];
    final studentId = args['id'];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/just.avif'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 70.0,
                        right: 30.0,
                        left: 30.0,
                        bottom: 30,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 158, 212, 219),
                                  Color.fromARGB(255, 35, 63, 102)
                                ],
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 610.0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Container(
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/user1.png'),
                                      radius: 50.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'USER DETAILS',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                    15.0,
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: namecontroller,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Name',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: 'Name',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      TextField(
                                        controller: agecontroller,
                                        maxLength: 2,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Age',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: 'Age',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          upDatedata(studentId);
                                          namecontroller.clear();
                                          agecontroller.clear();
                                         
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                            Size(
                                              double.infinity,
                                              50.0,
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                        ),
                                        child: Text('UPDATE'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
