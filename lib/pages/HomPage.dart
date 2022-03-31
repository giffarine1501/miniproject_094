import 'package:flutter/material.dart';
import 'package:myapp/adminpages/adminlogin.dart';
import 'package:myapp/pages/secondPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get fontSize => null;

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/rabbit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              menuHeader(),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              // welcomeText(),
              const Padding(padding: EdgeInsets.only(bottom: 500)),
              bottomBtn(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox bottomBtn() {
    return SizedBox(
      width: 200,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const secondPage(),
                )
            );
          },
          child: const Text(
            'เริ่มต้นใช้งาน',
            style: TextStyle(
              color: Colors.brown, 
              fontSize: 22,
              fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
            foregroundColor: MaterialStateProperty.all(Colors.brown),
          ),
        ),
      ),
    );
  }

  Row menuHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const adminLogin(),
                  builder: (context) => const LoginPage(),
                ));
          },
          icon: const Icon(Icons.person,
          size: 26),
          label: const Text('Admin', 
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,)),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.brown),
          ),
        ),
      ],
    );
  }
}
