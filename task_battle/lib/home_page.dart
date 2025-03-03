import 'package:flutter/material.dart';
import 'package:task_battle/new_task.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Фитнес',
      'tasks': ['Ходить 3 раза в день', 'Отжаться 50 раз', 'Приседания 25 раз'],
    },
    {
      'title': 'Утренняя рутина',
      'tasks': ['Проснуться в 6:00', 'Сделать зарядку', 'Принять душ', 'Медитировать'],
    },
    {
      'title': 'Домашние дела',
      'tasks': ['Убраться в квартире', 'Приготовить обед', 'Сходить в магазин'],
    },
    {
      'title': 'Учёба',
      'tasks': ['Сдать презентацию', 'Написать отчёт по физике', 'Разобраться с новой темой'],
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskBattle', style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.w700 )),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(title: tasks[index]['title'], tasks: tasks[index]['tasks']);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTaskScreen()),
        ),
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(29, 171, 97, 1),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final List<String> tasks;

  Color randomColor(){
    final Random random = Random();
    int green = 100 + random.nextInt(156);
    return Color.fromARGB(255, 0, green, 50);

  }

  TaskCard({required this.title, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: randomColor(),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 10),
            ...tasks.map((task) => Text('- $task', style: TextStyle(color: Colors.white))),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
    // Действие при нажатии
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Цвет фона кнопки
              foregroundColor: Colors.green, // Цвет текста и иконки // Растягивание по ширине 
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0), // Отступы вокруг содержимого кнопки
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Центрирование содержимого
                children: [
                  Image.asset(
                    'lib/assets/icons/Vector.png', // Путь к вашему PNG-изображению
                    width: 24, // Ширина изображения
                    height: 24, // Высота изображения
                  ),
                  SizedBox(width: 8), // Отступ между изображением и текстом
                  Text('Перейти к сессии'),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}



