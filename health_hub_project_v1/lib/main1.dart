import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form_page.dart'; // Ensure this form_page.dart exists for navigation to form

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health Tracker',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<double> _healthScores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: _healthScores.isEmpty
            ? Text('No data available')
            : LineChart(LineChartData(
          lineBarsData: [LineChartBarData(spots: _healthScores.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList())],
        )),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('Profile'), decoration: BoxDecoration(color: Colors.blue)),
            ListTile(title: Text('Profile'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))),
            ListTile(title: Text('Notes'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage()))),
            ListTile(title: Text('Sign Out'), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage())),
        tooltip: 'Add Score',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Profile')),
      body: Center(child: Text('Profile Page')),
    );
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Center(child: Text('Notes Page')),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            ElevatedButton(
              onPressed: () => _signup(),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() {
    if (_usernameController.text.isEmpty) {
      var random = Random();
      var username = 'User_${random.nextInt(10000)}';
      _usernameController.text = username;
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', _usernameController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }
}
