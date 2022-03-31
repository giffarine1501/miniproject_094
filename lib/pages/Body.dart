import 'package:flutter/material.dart';
class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Home(size: size),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'เลี้ยงกระต่าย ต้องรู้อะไรบ้าง',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 218, 145, 169), borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'assets/images/r1.png',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Text(
                    "ถ้าอยากเลี้ยงหนู",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'ต้องศึกษาวิธีการเลี้ยงกันก่อนนะฮะ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

