import 'package:flutter/material.dart';
import 'navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: BackButton(color: Colors.green, onPressed: () => MainNavigationBar.new()), // const Text('Назад', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        title: const Text('Профиль', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.w600 )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      
    );
    
  }
}
