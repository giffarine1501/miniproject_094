import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:myapp/adminpages/loginProfile.dart';
import 'package:myapp/adminpages/showmenu.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _FormKey = GlobalKey<FormState>();

  LoginProfile loginprofile = LoginProfile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/rabb.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome to',
                style: TextStyle(
                    color: Color.fromARGB(255, 209, 83, 135),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 180),
              child: const Text(
                'Rabbit-Rabbit',
                style: TextStyle(
                    color: Color.fromARGB(221, 236, 147, 191), fontSize: 22),
              ),
            ),
            formfield(context),
          ],
        ),
      ),
    );
    
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
    SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Form(
                key: _FormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: MultiValidator([
                          RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          loginprofile.email = email;
                        },
                      decoration: InputDecoration(
                        label: const Text(
                          'Email',
                          style: TextStyle(fontSize: 20),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator:
                            RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                        onSaved: (String? password) {
                          loginprofile.password = password;
                        },
                        obscureText: true,
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                          style: TextStyle(fontSize: 20),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 209, 83, 135),),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white54,
                          child: IconButton(
                              color: Color.fromARGB(255, 201, 19, 119),
                               onPressed: () async {
                                  if (_FormKey.currentState!.validate()) {
                                    _FormKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: loginprofile.email!,
                                              password: loginprofile.password!)
                                          .then((value) {
                                        _FormKey.currentState!.reset();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) {
                                          return const ShowMenu();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
                                },
                              icon: const Icon(
                                Icons.arrow_forward,
                              ),
                        ),
                      ),
                    ],
                  ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'กลับไปยังหน้าแรก',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 250, 233, 233),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    )
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

  