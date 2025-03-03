import 'package:flutter/material.dart';

class AddMembersScreen extends StatefulWidget {
  @override
  _AddMembersScreenState createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final List<Map<String, dynamic>> users = [
    {'name': 'Амир', 'selected': false, 'avatar': 'lib/assets/icons/kanye.jpg'},
    {'name': 'Ильнур', 'selected': false, 'avatar': 'lib/assets/icons/drake.jpg'},
    {'name': 'Женя', 'selected': false, 'avatar': 'lib/assets/icons/trav.jpg'},
    {'name': 'Денис', 'selected': false, 'avatar': 'lib/assets/icons/uzi.jpg'},
    {'name': 'что-то горячее', 'selected': false, 'avatar':'lib/assets/icons/sza.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить друзей', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: users
                    .where((user) => user['selected'])
                    .map((user) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundImage: AssetImage(user['avatar']),
                            ),
                            label: Text(user['name']),
                            onDeleted: () {
                              setState(() {
                                user['selected'] = false;
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(users[index]['avatar']),
                  ),
                  title: Text(users[index]['name']),
                  trailing: Checkbox(
                    value: users[index]['selected'],
                    onChanged: (bool? value) {
                      setState(() {
                        users[index]['selected'] = value ?? false;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      users[index]['selected'] = !users[index]['selected'];
                    });
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom:16, left:16, right:16),
              child: FloatingActionButton(
                onPressed: () => Navigator.pop(context), //Обработка синей стрелки
                backgroundColor: Colors.green,
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}