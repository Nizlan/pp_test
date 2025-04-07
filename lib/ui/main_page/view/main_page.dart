import 'package:flutter/material.dart';

import '../../convert_page/view/convert_page.dart';
import '../../rates_page/view/rates_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    RatesPage(),
    ConvertPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = _selectedIndex == 0 ? 'Rates' : 'Convert';

    return Scaffold(
      appBar: AppBar(
        leading:
            _selectedIndex == 0
                ? IconButton(icon: const Icon(Icons.refresh), onPressed: () {})
                : null,
        title: Text(appBarTitle),
        centerTitle: true,
        actions:
            _selectedIndex == 0
                ? [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ]
                : null,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Rates'),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Convert',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}
