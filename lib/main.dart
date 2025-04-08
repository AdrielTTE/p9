import 'package:flutter/material.dart';
import 'package:p9/ui/CreateUI.dart';
import 'package:p9/ui/DeleteUi.dart';
import 'package:p9/ui/HomeUi.dart';
import 'package:p9/ui/UpdateUi.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  // Example pages for each tab
  static final List<Widget> _pages = <Widget>[
    HomeUi('Product List'),
    CreateUi('Create Product'),
    Deleteui(),
    UpdateUi()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,            // Selected item color
        unselectedItemColor: Colors.grey,          // Unselected items color
        backgroundColor: Colors.white,             // Navigation bar background
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
        ],
      ),
    );
  }
}
