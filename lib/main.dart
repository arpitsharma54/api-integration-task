import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_01/provider/user_info.dart';

import 'screens/submit_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserInfo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taks_01',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SubmitScreen(),
        routes: {
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}
