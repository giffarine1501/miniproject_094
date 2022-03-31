import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Body.dart';
import 'package:myapp/pages/detail.dart';
class secondPage extends StatefulWidget {
  const secondPage({ Key? key }) : super(key: key);

  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {

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
            style: TextStyle(color: Colors.black, 
            fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: [
            Body(),
            showlist(),
          ],
        ),
        bottomNavigationBar: icon(context),
      ),
    );
  }

  Widget icon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
        color: Color.fromARGB(255, 236, 114, 155),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton( 
              icon: Image.asset("assets/icons/home.png",
              color: Colors.white),
              onPressed: () => Navigator.pop(context)
            ),
            IconButton( 
              icon: Image.asset("assets/icons/heart.png",
              color: Colors.white),
              onPressed: () {}
            ),
            IconButton( 
              icon: Image.asset("assets/icons/user.png",
              color: Colors.white),
              onPressed: () {}
            ),
        ],
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/images/r3.png'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(id: doc.id),
                        ),
                      ).then((value) => setState(() {}));
                    },
                    title: Text(
                      '${data['title']}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 236, 114, 155)
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    subtitle: Text("รายละเอียด"),
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