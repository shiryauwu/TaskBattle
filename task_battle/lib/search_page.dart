import 'package:flutter/material.dart';
import 'package:task_battle/navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSessionsSelected = true;

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
        centerTitle: true,
        title: const Text("Поиск", style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Поиск",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _toggleButton("Сессии", isSessionsSelected, () {
                  setState(() {
                    isSessionsSelected = true;
                  });
                }),
                const SizedBox(width: 10),
                _toggleButton("Люди", !isSessionsSelected, () {
                  setState(() {
                    isSessionsSelected = false;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isSessionsSelected ? _buildSessionsList() : _buildPeopleList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSessionsList() {
    final sessions = [
      {"title": "Фитнес", "members": 5, "color": Colors.green[800]},
      {"title": "Утренняя рутина", "members": 6, "color": Colors.green[600]},
      {"title": "Домашние дела", "members": 2, "color": Colors.green[400]},
      {"title": "Учеба", "members": 3, "color": Colors.green[200]},
    ];

    return ListView(
      children: sessions.map((session) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: session['color'] as Color?,
            radius: 20,
          ),
          title: Text(session['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${session['members']} участника", style: TextStyle(color: Colors.grey[600])),
        );
      }).toList(),
    );
  }

  Widget _buildPeopleList() {
    final people = [
      {"name": "Анюта", "status": "Был(а) в сети вчера", "image": "assets/avatar1.png", "online": false},
      {"name": "Антошка", "status": "Онлайн", "image": "assets/avatar2.png", "online": true},
      {"name": "Мадина", "status": "Был(а) в сети 3 часа назад", "image": "assets/avatar3.png", "online": false},
      {"name": "Лиза", "status": "Онлайн", "image": "assets/avatar4.png", "online": true},
      {"name": "Амир", "status": "Онлайн", "image": "assets/avatar5.png", "online": true},
      {"name": "Сосиска киллер_228", "status": "Был(а) в сети 30 минут назад", "image": "", "online": false},
    ];

    return ListView(
      children: people.map((person) {
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: person['image'] != "" ? AssetImage(person['image'] as String) : null,
                backgroundColor: Colors.blue,
                radius: 25,
                child: person['image'] == "" ? Text((person['name'] as String).substring(0, 2).toUpperCase(), style: const TextStyle(color: Colors.white)) : null,
              ),
              if (person['online'] as bool)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(person['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(person['status'] as String, style: TextStyle(color: Colors.grey[600])),
        );
      }).toList(),
    );
  }
}
