import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/adminpages/showmenu.dart';
class AddDetail extends StatefulWidget {
  const AddDetail({ Key? key }) : super(key: key);

  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  final _Formkey = GlobalKey<FormState>();

  TextEditingController _title = TextEditingController();
  TextEditingController _p1 = TextEditingController();

  CollectionReference parents = FirebaseFirestore.instance.collection('Parent');
  Future<void> addProduct() {
    return parents
        .add({
          'title': _title.text,
          'p1': _p1.text,
        })
        .then((value) {
          print("Product data has been successfully");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShowMenu(),
            ),
          );
        })
        .catchError((error) => print("Failed to add data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/1.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 145, 188),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: _Formkey,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: const Text(
                  'เพิ่มข้อมูล',
                  style: TextStyle(color: Colors.black, fontSize: 33),
                ),
              ),
              formfield(context),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView formfield(BuildContext context) {
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
                    validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'กรุณาป้อนข้อมูล';
                    }
                    return null;
                  },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      label: Text(
                        'หัวข้อ',
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade700),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
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
                      validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'กรุณาป้อนข้อมูล';
                    }
                    return null;
                  },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      label: Text(
                        'รายละเอียด',
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade700),
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
                      const Text(
                        'บันทึกข้อมูล',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.w700),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromARGB(255, 238, 204, 231),
                        child: IconButton(
                            color: Colors.pink,
                            onPressed: () {
                              addProduct();
                              
                            },
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
}