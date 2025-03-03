import 'package:flutter/material.dart';
import 'package:task_battle/adding_friends.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String? selectedMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Новая задача', style: TextStyle(color: Colors.green)), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          
          children: [
            TextField(decoration: InputDecoration(labelText: 'Название сессии', labelStyle: TextStyle(fontSize: 18) )), 
            SizedBox(height: 10),

            //Text('Участники: ', style: TextStyle(fontSize: 18)),
            //SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              TextButton(onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMembersScreen())), 
              child: 
              Text('+ Добавить друзей в сессию', style: TextStyle(fontSize: 18),)
              )
            ),
            SizedBox(height: 20),

            SingleChildScrollView(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Описание',
                  labelStyle: TextStyle(
                    fontSize: 18, // Размер текста labelText
                  ),
                  border: OutlineInputBorder(), // Рамка вокруг TextField
                ),
                keyboardType: TextInputType.multiline, // Многострочный ввод
                maxLines: null, // Позволяет TextField увеличиваться вертикально
              ),
            ),
            SizedBox(height: 30),

            Text("Режим сессии",style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),

            Column(
              children: <Widget>[
                RadioListTile<String>(
                  title: Text('Бесконечная'),
                  value: 'infinity',
                  groupValue: selectedMode,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMode = value; // Обновляем выбранное значение
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('До выполнения цели'),
                  value: 'terminal',
                  groupValue: selectedMode,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMode = value; // Обновляем выбранное значение
                    });
                  },
                ),
              ],
            ),

            SizedBox( height: 20,),
            ElevatedButton(onPressed: () {}, child: Text('Создать')),
          ],
        ),
      ),
    );
  }
  



}