import 'package:flutter/material.dart';
import 'package:task_battle/navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Заглушка для данных пользователя
  final String username = "Ильнур";
  final String handle = "@shirya_uwu";
  final int friends = 19;
  final int sessions = 4;
  final int points = 570;
  final String description = "Привет! Я Ильнур, люблю путешествовать и изучать новые технологии.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainNavigationBar()),
            );
          },
        ),
        centerTitle: true, // Делаем заголовок по центру
        title: const Text(
          'Профиль',
          style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(username, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(handle, style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.black)),
                    ),
                    child: const Text("Изменить профиль", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoColumn("Друзей", friends.toString()),
                _infoColumn("Сессий", sessions.toString()),
                _infoColumn("Баллов", points.toString()),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Добавьте описание...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              controller: TextEditingController(text: description),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
