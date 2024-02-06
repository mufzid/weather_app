import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/services/auth_provider';
import 'package:weather_app/src/utils/snackbar_helper.dart';
import 'package:weather_app/src/widgets/form_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 0, 191, 244),
                      Colors.white
                    ])),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    FromCondainerWidget(
                      controller: _usernamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<AuthProvider>().login(value!, '');
                      },
                      labeltext: 'UserName',
                      hintText: "UserName",
                      isPasswordField: false,
                    ),
                    FromCondainerWidget(
                      controller: _passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<AuthProvider>().login('', value!);
                      },
                      hintText: "Password",
                      isPasswordField: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsetsDirectional.symmetric(
                                horizontal: 80, vertical: 2),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 0, 191, 244),
                          )),
                      onPressed: () async {
                        if (_usernamecontroller.text.isNotEmpty &&
                            _passwordcontroller.text.isNotEmpty) {
                          await context.read<AuthProvider>().login(
                                _usernamecontroller.text,
                                _passwordcontroller.text,
                              );

                          if (authProvider.isLoggedIn) {
                            Navigator.pushNamed(context, '/list');
                            print('Login successful');
                          } else {
                            showErrorMessage(context, message: 'Login failed');
                            print('Login failed');
                          }
                        } else {
                          print('Please enter both username and password');
                          showErrorMessage(context,
                              message:
                                  'Please enter both username and password');
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }
}
