// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:projectmobile4/helpers/auth_helper.dart';
// import 'package:projectmobile4/helpers/database_helper.dart';
// import 'package:projectmobile4/models/todo_model.dart';
// import 'package:projectmobile4/providers/todo_provider.dart';
// import 'package:projectmobile4/screens/add_todo_screen.dart';
// import 'package:projectmobile4/screens/splash_screen.dart';

// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late TodoProvider todoProvider;
//   @override
//   void initState() {
//     todoProvider = Provider.of<TodoProvider>(context, listen: false);
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Test AppWrite"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout),
//               onPressed: () async {
//                 await AuthHelper.instance.logout();
//                 Get.to(() => const SplashScreen());
//               },
//             )
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const AddTodoScreen()));
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: Consumer<TodoProvider>(
//           builder: (context, todoProvider, child) {
//             return todoProvider.todos.isEmpty
//                 ? const Center(
//                     child: Text("Belum ada apapun"),
//                   )
//                 : ListView.builder(
//                     itemCount: todoProvider.todos.length,
//                     itemBuilder: (context, index) => Card(
//                           elevation: 10,
//                           shadowColor: Colors.blueAccent,
//                           color: Colors.yellow[200],
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     // Checkbox(
//                                     //   value: todoProvider.todos[index].isDone,
//                                     //   onChanged: (value) {
//                                     //     setState(() {
//                                     //       todoProvider.todos[index].isDone =
//                                     //           value!;
//                                     //       todoProvider.updateTodo(
//                                     //         index,
//                                     //         todoProvider.todos[index],
//                                     //       );
//                                     //     });
//                                     //   },
//                                     // ),
//                                     // Text(
//                                     //   "Hello ${todoProvider.todos[index].username}!", // Tambahkan baris ini
//                                     // ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               todoProvider
//                                                   .todos[index].namalengkap,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               "(${todoProvider.todos[index].createdAt.day}-${todoProvider.todos[index].createdAt.month}-${todoProvider.todos[index].createdAt.year})",
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 7,
//                                         ),
//                                         Text(todoProvider
//                                             .todos[index].nomortelepon)
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Color.fromARGB(255, 5, 153, 0),
//                                   ),
//                                   onPressed: () {
//                                     _showEdit(index);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       todoProvider.removeTodo(index);
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ));
//           },
//         ));
//   }

//   void getData() async {
//     await todoProvider.getTodo();
//   }

//   void _showEdit(int index) {
//     TextEditingController namalengkapController =
//         TextEditingController(text: todoProvider.todos[index].namalengkap);
//     TextEditingController nomorteleponController =
//         TextEditingController(text: todoProvider.todos[index].nomortelepon);
//     TextEditingController alamat1Controller =
//         TextEditingController(text: todoProvider.todos[index].alamat1);
//     TextEditingController alamat2Controller =
//         TextEditingController(text: todoProvider.todos[index].alamat2);
//     TextEditingController alamat3Controller =
//         TextEditingController(text: todoProvider.todos[index].alamat3);

//     showDialog(
//       context: context,
//       builder: (
//         BuildContext context,
//       ) {
//         return AlertDialog(
//           title: Text('Edit File'),
//           content: Container(
//             height: MediaQuery.of(context).size.height * 0.25,
//             child: Column(
//               children: [
//                 TextField(
//                   controller: namalengkapController,
//                   decoration: InputDecoration(labelText: 'Nama Lengkap'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: nomorteleponController,
//                   decoration: InputDecoration(labelText: 'Nomor Telepon'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: alamat1Controller,
//                   decoration: InputDecoration(labelText: 'Alamat1'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: alamat2Controller,
//                   decoration: InputDecoration(labelText: 'Alamat2'),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: alamat3Controller,
//                   decoration: InputDecoration(labelText: 'Alamat3'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 String newNamalengkap = namalengkapController.text.trim();
//                 String newNomorTelepon = nomorteleponController.text.trim();
//                 String newAlamat1 = alamat1Controller.text.trim();
//                 String newAlamat2 = alamat2Controller.text.trim();
//                 String newAlamat3 = alamat3Controller.text.trim();
//                 if (newNamalengkap.isNotEmpty &&
//                     newNomorTelepon.isNotEmpty &&
//                     newAlamat1.isNotEmpty &&
//                     newAlamat2.isNotEmpty &&
//                     newAlamat3.isNotEmpty) {
//                   // Update the TodoModel with the new data
//                   TodoModel updatedTodo = TodoModel(
//                     namalengkap: newNamalengkap,
//                     nomortelepon: newNomorTelepon,
//                     alamat1: newAlamat1,
//                     alamat2: newAlamat2,
//                     alamat3: newAlamat3,
//                     createdAt: todoProvider.todos[index].createdAt,
//                     userId: todoProvider.todos[index].userId,
//                     id: todoProvider.todos[index].id,
//                   );

//                   // Update the todo in the provider
//                   todoProvider.updateTodo(index, updatedTodo);

//                   // Update the todo in the database
//                   try {
//                     DatabaseHelper.instance.updateTodo(updatedTodo);
//                     Navigator.pop(context);
//                   } catch (e) {
//                     // Handle error
//                     print(e.toString());
//                   }
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
