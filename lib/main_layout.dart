import 'package:flutter/material.dart';
import 'pages/tasks_page.dart';
import 'package:provider/provider.dart';
import 'pages/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainLayout extends StatefulWidget {
  final String title;
  final Widget body;


  const MainLayout({
    required this.title,
    required this.body,

  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout> {

  int points = 0;

  void addPoints(int value) {
    setState(() {
      points += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),

      drawer: Drawer(
        child: ListView(
          children: [

            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(color: Colors.white);
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>?;

                  String name = userData?['name'] ?? 'Пользователь';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Очки: ${Provider.of<AppState>(context).points}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),

                      SizedBox(height: 10),

                      Text(
                        '$name',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ),

            // DrawerHeader(
            //   decoration: BoxDecoration(color: Colors.green),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Меню', style: TextStyle(color: Colors.white, fontSize: 20)),
            //       SizedBox(height: 10),
            //       Text(
            //         'Очки: ${appState.points}',
            //         style: TextStyle(color: Colors.white, fontSize: 18),
            //       ),
            //     ]
            //
            //   )
            //
            // ),

            ListTile(
              title: Text('Главная'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),

            ListTile(
              title: Text('Настройки'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),

            ListTile(
              title: Text('О приложении'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
            ListTile(
              title: Text('Задания'),
              onTap: () => Navigator.pushNamed(context, '/tasks'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Выйти'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),

      body: widget.body

    );
  }
}