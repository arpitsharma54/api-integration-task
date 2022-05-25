import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  String avatar;
  String email;
  String firstName;
  String lastName;

  UsersList({
    Key? key,
    required this.avatar,
    required this.email,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Column(
          children: [
            const Divider(color: Colors.black54),
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(avatar),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(email),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
