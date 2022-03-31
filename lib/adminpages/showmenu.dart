import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/adminpages/Adddetail.dart';
import 'package:myapp/adminpages/Editdetail.dart';
import 'package:myapp/pages/Body.dart';
import 'package:myapp/pages/HomPage.dart';

class ShowMenu extends StatefulWidget {
  const ShowMenu({ Key? key }) : super(key: key);

  @override
  State<ShowMenu> createState() => _ShowMenuState();
}

class _ShowMenuState extends State<ShowMenu> {
  @override
  _ShowMenuState createState() => _ShowMenuState();
  CollectionReference parents = FirebaseFirestore.instance.collection('Parent');

  Future<void> deleteProduct({required String id}) {
    return parents
        .doc(id)
        .delete()
        .then((value) => print("Deleted data Successfully"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 204, 216),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Rabbit Rabbit",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            )
          ],

          // backgroundColor: Colors.transparent,
          // elevation: 0.0,
        ),
        body: ListView(
          children: [
            Body(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: showlist(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddDetail(),
              ),
            ).then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget showlist() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Parent').snapshots(),
      // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      builder: (context, snapshot) {
        List<Widget> listMe = [];
        if (snapshot.hasData) {
          var parents = snapshot.data;
          listMe = [
            Column(
              children: parents!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDetail(id: doc.id),
                        ),
                      ).then((value) => setState(() {}));
                    },
                    title: Text(
                      '${data['title']}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 236, 114, 155)),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        var alertDialog = AlertDialog(
                          title: const Text('ยืนยันการลบข้อมูล'),
                          content: Text(
                              'คุณต้องการลบ ${data['title']} ใช่หรือไม่'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  deleteProduct(id: doc.id)
                                      .then((value) => Navigator.pop(context));
                                },
                                child: const Text(
                                  'ยืนยัน',
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => alertDialog,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ];
        }
        return Center(
          child: Column(
            children: listMe,
          ),
        );
      },
    );
  }
}
