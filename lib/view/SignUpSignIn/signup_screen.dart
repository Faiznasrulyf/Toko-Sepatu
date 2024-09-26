import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/helpers/auth_helper.dart';
import 'package:sepatuv5/models/login_cred_model.dart';
import 'package:sepatuv5/view/SignUpSignIn/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                      const Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
                        child: Text(
                          'Sign Up',
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
                                labelText: 'Username',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan username di sini';
                              }
                              return null;
                            },
                            onSaved: (newValue) =>
                                _loginCredModel.username = newValue,
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
                                  borderRadius: BorderRadius.circular(8)),
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
                          padding: const EdgeInsets.only(bottom: 25),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('creating user...')));
                            try {
                              bool result =
                                  await AuthHelper.instance.signUpEmailPassword(
                                _loginCredModel.email!,
                                _loginCredModel.password!,
                                username: _loginCredModel.username,
                              );
                              if (result) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('logged in')));
                                Get.to(() => const LoginScreen());
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        child: const Text(
                          'Create account',
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
                          Text("have any account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: Text('Sign In'),
                          ),
                        ],
                      )
                          // const Text("Tidak Punya Akun? Sign up"),
                          ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
