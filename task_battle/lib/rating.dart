import 'package:flutter/material.dart';

class TaskBattleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RatingScreen(),
    );
  }
}

class RatingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {'name': 'София', 'xp': 750, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Константин', 'xp': 600, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Ильнур (Вы)', 'xp': 570, 'avatar': 'lib/assets/icons/kanye.jpg', 'highlight': true},
    {'name': 'Антошка', 'xp': 430, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Нургуль', 'xp': 410, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Дарья', 'xp': 250, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Эдуард', 'xp': 110, 'avatar': 'lib/assets/icons/kanye.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рейтинг', style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Назад', style: TextStyle(color: Colors.green, fontSize: 18)),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTopUser('Асап Роки', 1000, 'lib/assets/icons/kanye.jpg', 'lib/assets/icons/XP.png'),
                _buildTopUser('Алина', 1450, 'lib/assets/icons/kanye.jpg', 'lib/assets/icons/XP.png'),
                _buildTopUser('Денис', 900, 'lib/assets/icons/kanye.jpg', 'lib/assets/icons/XP.png'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: users[index]['highlight'] == true ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(users[index]['avatar']),
                    ),
                    title: Text(users[index]['name'],
                        style: TextStyle(
                          color: users[index]['highlight'] == true ? Colors.white : Colors.black,
                        )),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${users[index]['xp']} XP',
                          style: TextStyle(
                            color: users[index]['highlight'] == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Image.asset('lib/assets/icons/XP.png', width: 24, height: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUser(String name, int xp, String avatar, String medal) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(avatar),
          radius: 30,
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(medal, width: 20, height: 20),
            SizedBox(width: 4),
            Text('$xp XP', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}