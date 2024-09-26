import 'package:flutter/material.dart';
import 'package:sepatuv5/helpers/database_helper.dart';
import 'package:sepatuv5/models/todo_model.dart';
import 'package:sepatuv5/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TodoProvider todoProvider;
  @override
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    getData();
    super.initState();
  }

  void getData() async {
    await todoProvider.getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        // backgroundColor: Color.fromARGB(255, 41, 41, 41),
      ),
      // backgroundColor: Color.fromARGB(255, 41, 41, 41),
      body: Column(
        children: [
          // Center(
          //   child: GestureDetector(
          //     onTap: _pickImage,
          //     child: CircleAvatar(
          //       radius: 50,
          //       backgroundImage:
          //           _selectedImage != null ? FileImage(_selectedImage!) : null,
          //       child: _selectedImage == null
          //           ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
          //           : null,
          //     ),
          //   ),
          // ),

          SizedBox(
            height: 200,
          ),
          const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 105, 105, 105)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Alamat",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _tambahAlamat(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Tambah',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Check if todos is empty or not
          Consumer<TodoProvider>(
            builder: (context, todoProvider, child) {
              if (todoProvider.todos.isEmpty) {
                return const Center(
                  child: Text("Belum ada apapun"),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: todoProvider.todos.length,
                  itemBuilder: (context, index) => Card(
                    color: Color.fromARGB(255, 233, 233, 233),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    todoProvider.todos[index].namalengkap,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(" \t|\t  "),
                                  Text(
                                    todoProvider.todos[index].nomortelepon,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(todoProvider.todos[index].alamat2),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(todoProvider.todos[index].alamat1),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(todoProvider.todos[index].alamat3),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 109, 109, 109),
                                ),
                                onPressed: () {
                                  _showEdit(index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 186, 87, 87),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // title: Text("Confirmation"),
                                        content: Text(
                                            "Yakin Ingin Hapus Alamat Ini?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // If "Yes" is pressed, remove the item and close the dialog
                                              setState(() {
                                                todoProvider.removeTodo(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Ya"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // If "No" is pressed, simply close the dialog
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Tidak"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _tambahAlamat(BuildContext context) {
    late TodoProvider todoProvider;
    void initState() {
      todoProvider = Provider.of<TodoProvider>(context, listen: false);
      super.initState();
    }

    void getData() async {
      await todoProvider.getTodo();
    }

    final _formKey = GlobalKey<FormState>();
    String _namalengkap = '';
    String _nomortelepon = '';
    String _alamat1 = '';
    String _alamat2 = '';
    String _alamat3 = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Alamat'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.70,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Kontak"),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Nama Lengkap'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tolong isi Nama";
                        }
                        return null;
                      },
                      onSaved: (newValue) => _namalengkap = newValue ?? "Nama",
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Nomor Telepon'),
                      onSaved: (newValue) =>
                          _nomortelepon = newValue ?? "nomor telepon",
                    ),
                    SizedBox(height: 10),
                    Text("Alamat"),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Kecamatan, Kota, Provinsi'),
                      onSaved: (newValue) => _alamat1 = newValue ?? "alamat1",
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Nama Jalan, Gedung, No Rumah'),
                      onSaved: (newValue) => _alamat2 = newValue ?? "alamat2",
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Detail Lainnya (Blok/Unit/Patokan/dll)'),
                      onSaved: (newValue) => _alamat3 = newValue ?? "alamat3",
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //save the form
                          _formKey.currentState!.save();
                          //navigate to home screen
                          try {
                            bool result = await DatabaseHelper.instance
                                .createTodo(
                                    namalengkap: _namalengkap,
                                    nomortelepon: _nomortelepon,
                                    alamat1: _alamat1,
                                    alamat2: _alamat2,
                                    alamat3: _alamat3);
                            if (result) {
                              getData();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Menambahkan File Sukses")));
                            }
                          } catch (e) {
                            //snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Tambahkan File"),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //save the form
                  _formKey.currentState!.save();
                  //navigate to home screen
                  try {
                    bool result = await DatabaseHelper.instance.createTodo(
                        namalengkap: _namalengkap,
                        nomortelepon: _nomortelepon,
                        alamat1: _alamat1,
                        alamat2: _alamat2,
                        alamat3: _alamat3);
                    if (result) {
                      getData();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Menambahkan File Sukses")));
                    }
                  } catch (e) {
                    //snackbar
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }

                Navigator.pop(context);
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _showEdit(int index) {
    TextEditingController namalengkapController =
        TextEditingController(text: todoProvider.todos[index].namalengkap);
    TextEditingController nomorteleponController =
        TextEditingController(text: todoProvider.todos[index].nomortelepon);
    TextEditingController alamat1Controller =
        TextEditingController(text: todoProvider.todos[index].alamat1);
    TextEditingController alamat2Controller =
        TextEditingController(text: todoProvider.todos[index].alamat2);
    TextEditingController alamat3Controller =
        TextEditingController(text: todoProvider.todos[index].alamat3);

    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text('Edit File'),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namalengkapController,
                    decoration: InputDecoration(labelText: 'Nama Lengkap'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: nomorteleponController,
                    decoration: InputDecoration(labelText: 'Nomor Telepon'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: alamat1Controller,
                    decoration: InputDecoration(labelText: 'Alamat1'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: alamat2Controller,
                    decoration: InputDecoration(labelText: 'Alamat2'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: alamat3Controller,
                    decoration: InputDecoration(labelText: 'Alamat3'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newNamalengkap = namalengkapController.text.trim();
                String newNomorTelepon = nomorteleponController.text.trim();
                String newAlamat1 = alamat1Controller.text.trim();
                String newAlamat2 = alamat2Controller.text.trim();
                String newAlamat3 = alamat3Controller.text.trim();
                if (newNamalengkap.isNotEmpty &&
                    newNomorTelepon.isNotEmpty &&
                    newAlamat1.isNotEmpty &&
                    newAlamat2.isNotEmpty &&
                    newAlamat3.isNotEmpty) {
                  // Update the TodoModel with the new data
                  TodoModel updatedTodo = TodoModel(
                    namalengkap: newNamalengkap,
                    nomortelepon: newNomorTelepon,
                    alamat1: newAlamat1,
                    alamat2: newAlamat2,
                    alamat3: newAlamat3,
                    createdAt: todoProvider.todos[index].createdAt,
                    userId: todoProvider.todos[index].userId,
                    id: todoProvider.todos[index].id,
                  );

                  // Update the todo in the provider
                  todoProvider.updateTodo(index, updatedTodo);

                  // Update the todo in the database
                  try {
                    DatabaseHelper.instance.updateTodo(updatedTodo);
                    Navigator.pop(context);
                  } catch (e) {
                    // Handle error
                    print(e.toString());
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
