import 'package:flutter/material.dart';
import 'package:task_01/provider/user_info.dart';

import '../widgets/users_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../provider/user_details.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });
    Provider.of<UserInfo>(context, listen: false).fetchUsers().then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserInfo>(context, listen: false).users;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile'),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: userList.length,
                itemBuilder: (ctx, i) => UsersList(
                  avatar: userList[i]['avatar'],
                  email: userList[i]['email'],
                  firstName: userList[i]['first_name'],
                  lastName: userList[i]['last_name'],
                ),
              ),
            ),
    );
  }
}
