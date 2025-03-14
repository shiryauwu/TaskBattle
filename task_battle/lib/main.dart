import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_battle/auth_page.dart';
import 'navigation_bar.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = await _getUser();

  runApp(MyApp(user: user));
}

Future<User?> _getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final username = prefs.getString('username');
  final email = prefs.getString('email');
  final id = prefs.getString('id');

  if (token != null && username != null && email != null && id != null) {
    return User(
      id: id,
      username: username,
      email: email,
      token: token,
    );
  }

  return null;
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskBattle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: user != null ? const MainNavigationBar() : const AuthScreen(),
    );
  }
}
