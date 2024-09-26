import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/providers/todo_provider.dart';
import 'package:sepatuv5/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('6570bf0a1d14571e24bb')
      .setSelfSigned(status: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: const GetMaterialApp(
        title: 'Material App',
        home: SplashScreen(),
      ),
    );
  }
}
