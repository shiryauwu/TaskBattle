import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task_battle/home_page.dart';
import 'package:task_battle/profile_page.dart';
import 'package:task_battle/rating_page.dart';
import 'package:task_battle/search_page.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => _MainNavigationBar();
}

class _MainNavigationBar extends State<MainNavigationBar>{
  final List<Widget> _pages = [
    const HomePage(),
    const RatingPage(),
    const SearchPage(),
    const ProfilePage()
  ];

  int _selectedItem = 0;

  void _navigate(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  Color _getBackgroundColor(int index) {
    return _selectedItem == index ? const Color(0xff303437) : Colors.white;
  }

  Widget _setIcon(Image iconData, String text, int index) {
    return Container(
      width: 122.0, //double.infinity,
      height: 44.0, //kBottomNavigationBarHeight,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: _getBackgroundColor(index),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconData,
              Container(width: 2.0,),
              Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 14, ))
            ],
          ),
          onTap: () => _navigate(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedItem],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          selectedItemColor: const Color(0xff303437),
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: _setIcon(
              _selectedItem==0 ? Image.asset('lib/assets/icons/home_selected_icon.png') : Image.asset('lib/assets/icons/home_icon.png'), 
              _selectedItem==0 ? 'Главная' : '', 
              0),
              label: ''),
            BottomNavigationBarItem(icon: _setIcon(
              _selectedItem==1 ? Image.asset('lib/assets/icons/rating_selected_icon.png') : Image.asset('lib/assets/icons/rating_icon.png'), 
              _selectedItem==1 ? 'Рейтинг' : '', 
              1),
              label: ''),
            BottomNavigationBarItem(icon: _setIcon(
              _selectedItem==2 ? Image.asset('lib/assets/icons/search_selected_icon.png') : Image.asset('lib/assets/icons/search_icon.png'), 
              _selectedItem==2 ? 'Поиск' : '', 
              2), 
              label: ''),
            BottomNavigationBarItem(icon: _setIcon(
              _selectedItem==3 ? Image.asset('lib/assets/icons/profile_selected_icon.png') : Image.asset('lib/assets/icons/profile_icon.png'),
              _selectedItem==3 ? 'Профиль' : '',
              3),
              label: ''),
          ]
      )
    );
  }

}

