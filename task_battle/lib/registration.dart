import 'package:flutter/material.dart';

void main() {
  runApp(TaskBattleApp());
}

class TaskBattleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isLogin ? 'Вход' : 'Регистрация',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Логин', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            if (!isLogin)
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Почта', border: OutlineInputBorder()),
              ),
            if (!isLogin) SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль', border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(isLogin ? 'Войти' : 'Зарегистрироваться', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
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



