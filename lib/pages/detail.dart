import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Detail extends StatefulWidget {
  const Detail({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 204, 216),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 236, 114, 155),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "รายละเอียด",
            style: TextStyle(color: Colors.black, 
            fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_sharp),
              onPressed: () {},
            )
          ],
        ),
        body: showDetail(context),
        bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
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
      ),
    );
  }

  Widget showDetail(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference parents = FirebaseFirestore.instance.collection('Parent');
    return FutureBuilder<DocumentSnapshot>(
      future: parents.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            children: [
              Expanded(
                child: Column(                         
                  children: [
                    SizedBox(
                      width: double.infinity, 
                      child: Container(
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 114, 155)),
                        child: Image.asset('assets/images/r2.png'),
                      ),
                    ),
                  ],      
                ), 
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${data['title']}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      Column(
                        children: [
                          Text(
                            '${data['p1']}',
                            style: const TextStyle(
                                height: 1.5,
                                fontSize: 20,
                                color: Colors.black54),
                                textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const Text('Loading');
      },
    );
  }

  SizedBox picture() {
    return SizedBox(
      height: 280,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/r2.png')),
        ),
      ),
    );
  }
}