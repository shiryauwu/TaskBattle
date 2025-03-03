import 'package:flutter/material.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Назад", style: TextStyle(color: Colors.green, fontSize: 16)),
        ),
        title: const Center(
          child: Text(
            "Алина",
            style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [SizedBox(width: 60)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/friend_pic.jpg'),
          ),
          const SizedBox(height: 10),
          const Text("@keedenN", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoColumn("Друзей", "28"),
              _infoColumn("Сессий", "11"),
              _infoColumn("Баллов", "1450"),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            icon: const Icon(Icons.person_remove, color: Colors.black),
            label: const Text("Удалить из друзей", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}