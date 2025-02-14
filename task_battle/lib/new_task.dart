import 'package:flutter/material.dart';

String? selectedMode; // Переменная для хранения выбранного значения

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Новая задача', style: TextStyle(color: Colors.green)), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Название сессии',   )), 
            SizedBox(height: 10),

            Text('Кому назначено: ', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            TextButton(onPressed: () => _showSessionDialog(context), child: Text('+ Пригласить друзей')),

            TextField(decoration: InputDecoration(labelText: 'Описание')),
            SizedBox(height: 10),

            Text("Режим сессии",style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            Column(
              children: <Widget>[
                RadioListTile<String>(
                  title: Text('Бесконечная'),
                  value: 'infinity',
                  groupValue: selectedMode,
                  onChanged: (String? value) {
                    setState() {
                      selectedMode = value; // Обновляем выбранное значение
                    };
                  },
                ),
                RadioListTile<String>(
                  title: Text('До выполнения цели'),
                  value: 'terminal',
                  groupValue: selectedMode,
                  onChanged: (String? value) {
                    setState() {
                      selectedMode = value; // Обновляем выбранное значение
                    };
                  },
                ),
              ],
            ),


            ElevatedButton(onPressed: () {}, child: Text('Создать')),
          ],
        ),
      ),
    );
  }
  


  void _showSessionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
height: 200,
          child: Column(
            children: [
              Text('Добавить сессию', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Название сессии')),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Сохранить')),
            ],
          ),
        );
      },
    );
  }
}