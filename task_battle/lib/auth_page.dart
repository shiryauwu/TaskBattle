import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';
import '../navigation_bar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isLogin = true;

  Future<void> _authenticate() async {
    try {
      final url = Uri.parse('http://46.29.161.173:80/api/v1/User/${isLogin ? 'authorize' : 'register'}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username' : usernameController.text,
          !isLogin?'email': '': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        User user = User.fromJson(data);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', user.token.toString());
        await prefs.setString('username', user.username.toString());
        await prefs.setString('id', user.id.toString());

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationBar()),
        );
      } else if (response.statusCode == 400 && !isLogin) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: Некорректный формат email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Вход' : 'Регистрация',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Логин'),
            ),
            const SizedBox(height: 8),
            if (!isLogin)
              const SizedBox(height: 8),
            if (!isLogin)
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                obscureText: false,
              ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            if (!isLogin)
              const SizedBox(height: 8),
            if (!isLogin)
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Повторите пароль'),
                obscureText: true,
              ),
             
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  usernameController.clear();
                  passwordController.clear();
                  confirmPasswordController.clear();
                });
              },
              child: Text(isLogin ? 'Нет аккаунта? Регистрация' : 'Уже есть аккаунт? Войти'),
            ),
          ],
        ),
      ),
    );
  }
}