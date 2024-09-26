import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/helpers/auth_helper.dart';
import 'package:sepatuv5/models/login_cred_model.dart';
import 'package:sepatuv5/view/SecondScreen/SecondScreen.dart';

import 'package:sepatuv5/view/SignUpSignIn/signup_screen.dart';
import 'package:sepatuv5/view/homeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final LoginCredModel _loginCredModel = LoginCredModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87,
                  Colors.blue,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.to(SecondScreen());
                        },
                        icon: const Icon(Icons.arrow_right_alt_outlined),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'masukan email disini';
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              _loginCredModel.email = newValue,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onSaved: (newValue) =>
                              _loginCredModel.password = newValue,
                          validator: (value) => value!.length < 6
                              ? 'Password harus lebih dari 6 karakter'
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('logging in...')));
                          try {
                            bool result = await AuthHelper.instance
                                .loginEmailPassword(_loginCredModel.email!,
                                    _loginCredModel.password!);
                            if (result) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('logged in')));
                              Get.to(() => SecondScreen());
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            // color: Color.fromARGB(14, 0, 0, 0),
                            ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't have any account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ));
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    )
                        // const Text("Tidak Punya Akun? Sign up"),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
