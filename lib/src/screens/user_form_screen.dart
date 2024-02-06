import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/src/models/user_data_model.dart';
import 'package:weather_app/src/services/user_data.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text("User Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const Gap(10),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Firstname';
                  }
                  return null;
                },
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  hintText: 'Your First Name',
                  hintStyle: const TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 92, 92, 92),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 234, 255),
                    ),
                  ),
                )),
            const Gap(16),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Last Name';
                  }
                  return null;
                },
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  hintText: 'Your Last Name',
                  hintStyle: const TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 92, 92, 92),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 191, 244),
                    ),
                  ),
                )),
            const Gap(16),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  hintText: 'example@email.com',
                  hintStyle: const TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 92, 92, 92),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 234, 255),
                    ),
                  ),
                )),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsetsDirectional.symmetric(
                            horizontal: 40, vertical: 2),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueGrey)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsetsDirectional.symmetric(
                            horizontal: 45, vertical: 2),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 45, 61, 70),
                      )),
                  onPressed: () {
                    saveUser();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveUser() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    User user = User(firstName: firstName, lastName: lastName, email: email);
    UserDataHelper userDataHelper = UserDataHelper();
    await userDataHelper.insertUser(user);
    Navigator.pop(context);
  }
}
