import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/views/MyHomePage.dart';
import 'package:shopping_app/views/Sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key, required String title});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  bool hiddenPassword = true;
  bool hiddenConfirm = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 78, 128),
        title: Text(
          "Login Page",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/imagebackgroungd.JPEG'),
                fit: BoxFit.fill)),
        child: Center(
          child: Form(
              key: _formKey,
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "Login",
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
                          prefixIcon: Icon(Icons.email))),
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
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (credential.user != null) {
                              Navigator.of(context).push((MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        title: 'Home Page',
                                      ))));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Invalid Email or Password')));
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message ?? '--')));
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push((MaterialPageRoute(
                                builder: (context) => Signup(
                                      title: 'SignUp',
                                    ))));
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          )),
                    ],
                  ),
                )
              ])),
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

  bool isFirstCapital(String name) {
    String firstChar = name[0];
    return firstChar == firstChar.toUpperCase();
  }
}
