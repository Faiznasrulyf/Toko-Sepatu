import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/helpers/auth_helper.dart';
import 'package:sepatuv5/screens/splash_screen.dart';
import 'package:sepatuv5/view/SecondScreen/SecondScreen.dart';
import 'components/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imagePaths = [
    'gambar/women1.jpg',
    'gambar/women2.jpg',
    'gambar/women3.jpg',
    'gambar/women4.jpg',
  ];

  final AuthHelper _authHelper = AuthHelper.instance;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    if (await _authHelper.isLoggedIn()) {
      final userId = await _authHelper.getUserId();
      final username = await _authHelper.getUsernameById(userId!);
      setState(() {
        _username = username ?? 'Guest';
      });
    } else {
      setState(() {
        _username = 'Guest';
      });
    }
  }

  // final AuthController _authController = Get.put(AuthController());
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String username = _authController.getCurrentUserDisplayName() ?? 'Guest';

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      _showAccountDialog();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.black,
                        child: ClipOval(
                          child: Image.asset(
                            'gambar/man.png',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                // 'Welcome, $username',
                'Welcome, $_username',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Discover The latest styles',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Stories',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              height: 400,
              child: PageView.builder(
                itemCount: imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29.0),
                          child: Image.asset(
                            imagePaths[index],
                            width: 300,
                            height: 500,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                'Meet Someone Manuel',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "italic",
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ),
            const SizedBox(height: 7.0),
            const Center(
              child: Text(
                '#WePlayReal',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "italic",
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarFb1(),
    );
  }

  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Setting'),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                const SizedBox(height: 13),
                // if (AuthHelper.instance.isLoggedIn() == true)
                Container(
                  child: TextButton(
                    onPressed: () {
                      // LoginPage();
                      Get.to(SecondScreen());
                    },
                    child: const Text(
                      'LogIn Account',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //Icon(Icons.delete),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: TextButton(
                    onPressed: () {
                      AuthHelper.instance.logout();
                      Get.to(() => const SplashScreen());
                    },
                    child: const Text(
                      'LogOut Account',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //Icon(Icons.delete),
                  ),
                ),
                SizedBox(height: 0),
                // Container(
                //   child: TextButton(
                //     onPressed: () {
                //       // _showDeleteAccountDialog();
                //     },
                //     child: Text(
                //       'Delete Account',
                //       style: TextStyle(
                //         fontSize: 20,
                //       ),
                //     ),
                //     //Icon(Icons.delete),
                //   ),
                // ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // void _showDeleteAccountDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Delete Account'),
  //         content: Container(
  //           height: MediaQuery.of(context).size.height * 0.2,
  //           child: Column(
  //             children: [
  //               Container(
  //                 width: MediaQuery.of(context).size.width * 0.8,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(bottom: 25),
  //                   child: TextField(
  //                     controller: _emailController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Email',
  //                       contentPadding:
  //                           EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width * 0.8,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(bottom: 50),
  //                   child: TextField(
  //                     controller: _passwordController,
  //                     obscureText: true,
  //                     decoration: InputDecoration(
  //                       labelText: 'Password',
  //                       contentPadding:
  //                           EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // _deleteAccount();
  //             },
  //             child: Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _deleteAccount() async {
  //   try {
  //     await _authController.deleteAccount(
  //       _emailController.text,
  //       _passwordController.text,
  //     );
  //     Navigator.pop(context);
  //     Get.offAll(HomeScreen());
  //   } catch (error) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to delete account: $error',
  //       backgroundColor: Colors.red,
  //     );
  //     Get.offAll(LoginPage());
  //   }
  // }
}
