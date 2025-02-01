import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/views/Login.dart';
import 'package:shopping_app/views/MyHomePage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required String title});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool hiddenPassword = true;
  bool hiddenConfirm = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCloseDialog() {
    _controller.forward().then((_) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => MyHomePage(title: 'Shopping App'),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 78, 128),
        title: Text(
          "SignUp Page",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/imagebackgroungd.JPEG'),
                fit: BoxFit.fill)),
        child: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 47, 78, 128),
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value != null && value!.isEmpty) {
                          return 'Please enter your name';
                        } else if (!isFirstCapital(value!)) {
                          return 'First letter should be capital';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Full name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 47, 78, 128),
                                width: 2),
                          ),
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value != null && value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value!.contains('@gmail.com')) {
                          return 'Email must contains @gmail.com';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 47, 78, 128),
                                width: 2),
                          ),
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value != null && value!.isEmpty) {
                            return 'Please enter your Password';
                          } else if (value!.length < 6) {
                            return 'Passwors must contains at least 6 characters';
                          }
                        },
                        obscureText: hiddenPassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 47, 78, 128),
                                  width: 2),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                togglePassword();
                              },
                              icon: Icon(hiddenPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value != null && value!.isEmpty) {
                            return 'Please confirm your Password';
                          } else if (!isEqual(
                              value!, passwordController.text)) {
                            return 'Passwors and Confirm Password doesn not match';
                          }
                        },
                        obscureText: hiddenConfirm,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 47, 78, 128),
                                  width: 2),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  toggleConfirm();
                                },
                                icon: Icon(hiddenConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 47, 78, 128)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            minimumSize:
                                MaterialStateProperty.all(Size(300, 50))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Signup Successful! Please login.')));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Signup Failed: $e')));
                            }
                            myDialog();
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ])),
          ),
        ),
      ),
    );
  }

  togglePassword() {
    hiddenPassword = !hiddenPassword;
    setState(
      () {},
    );
  }

  toggleConfirm() {
    hiddenConfirm = !hiddenConfirm;
    setState(
      () {},
    );
  }

  bool isFirstCapital(String name) {
    String firstChar = name[0];
    return firstChar == firstChar.toUpperCase();
  }

  bool isEqual(String pass, String confirmPass) {
    return pass == confirmPass;
  }

  Future<void> myDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Hello",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content: Text("Account created successfully",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              child: const Text("OK",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Login(
                          title: 'Login Page',
                        )));
              },
            ),
          ],
        );
      },
    );
  }
}
