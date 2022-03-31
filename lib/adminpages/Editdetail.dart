import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditDetail extends StatefulWidget {
  const EditDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  TextEditingController _title = TextEditingController();
  TextEditingController _p1 = TextEditingController();


  CollectionReference parents = FirebaseFirestore.instance.collection('Parent');

  Future<void> updateProduct() {
    return parents.doc(widget.id).update({
      'title': _title.text,
      'p1': _p1.text,
    }).then((value) {
      print("Data updated successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/1.jpg'), 
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 145, 188),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'แก้ไขข้อมูล',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            editformfield(context),
          ],
        ),
      ),
    );
  }

  Widget editformfield(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: parents.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _title.text = data['title'];
          _p1.text = data['p1'];

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _title,
                          decoration: InputDecoration(
                            label: Text(
                              'หัวข้อ',
                              style: TextStyle(
                                  fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _p1,
                          decoration: InputDecoration(
                            label: Text(
                              'รายละเอียด',
                              style: TextStyle(
                                  fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'บันทึกข้อมูล',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Color.fromARGB(255, 238, 204, 231),
                              child: IconButton(
                                  color: Colors.pink,
                                  onPressed: updateProduct,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Text('Loading');
      },
    );
  }
}