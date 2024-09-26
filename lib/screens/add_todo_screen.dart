//add todo screen
import 'package:flutter/material.dart';
import 'package:sepatuv5/helpers/database_helper.dart';
import 'package:sepatuv5/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late TodoProvider todoProvider;
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _namalengkap = '';
  String _nomortelepon = '';
  String _alamat1 = '';
  String _alamat2 = '';
  String _alamat3 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambahkan File"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Judul",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tolong isi Judul";
                  }
                  return null;
                },
                onSaved: (newValue) => _namalengkap = newValue ?? "Judul",
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Nomor Telefon",
                ),
                onSaved: (newValue) =>
                    _nomortelepon = newValue ?? "nomor telepon",
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "alamat1",
                ),
                onSaved: (newValue) => _alamat1 = newValue ?? "alamat1",
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "alamat2",
                ),
                onSaved: (newValue) => _alamat2 = newValue ?? "alamat2",
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "alamat3",
                ),
                onSaved: (newValue) => _alamat3 = newValue ?? "alamat3",
              ),
              ElevatedButton(
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
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
                child: const Text("Tambahkan File"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    await todoProvider.getTodo();
  }
}
