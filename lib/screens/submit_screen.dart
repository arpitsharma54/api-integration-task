import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_01/provider/user_info.dart';
import 'package:task_01/screens/profile_screen.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode nameTextField = FocusNode();

  final FocusNode jobTextField = FocusNode();

  final TextEditingController fullName = TextEditingController();

  final TextEditingController jobName = TextEditingController();

  bool isSubmited = false;

  Future<void> submitDetails(BuildContext context) async {
    setState(() {
      isSubmited = true;
    });
    Provider.of<UserInfo>(context, listen: false)
        .postUser(fullName.text, jobName.text)
        .then((value) {
      setState(() {
        Navigator.of(context).pushNamed(ProfileScreen.routeName).then((value) {
          setState(() {
            isSubmited = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboeardOpen = MediaQuery.of(
      context,
    ).viewInsets.bottom;
    if (isKeyboeardOpen == 0) {
      nameTextField.unfocus();
      jobTextField.unfocus();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: isSubmited
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: const Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!value.contains(RegExp(r'^[a-zA-Z]+$'))) {
                            return 'Please enter the name in string only';
                          }
                          return null;
                        },
                        focusNode: nameTextField,
                        controller: fullName,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: const Text(
                          'Job Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        focusNode: jobTextField,
                        controller: jobName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!value.contains(RegExp(r'^[a-zA-Z]+$'))) {
                            return 'Please enter the name in string only';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 280,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: double.infinity - 20,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                submitDetails(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please fill valid values')));
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
