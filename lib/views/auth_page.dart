import 'package:care_assist/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/services/authentication.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(
          top: 100,
          left: MediaQuery.of(context).size.width / 4,
        ),
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10.0,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (val) => name = val ?? '',
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Email cannot be empty';
                  } else if (!EmailValidator.validate(val)) {
                    return 'Not a valid email';
                  }
                  return null;
                },
                onSaved: (val) => email = val ?? '',
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (passwordController.text.length < 8) {
                    return 'Password not long enough';
                  }
                  return null;
                },
                onSaved: (val) => password = val ?? '',
                obscureText: true,
              ),
              Row(
                spacing: 10.0,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final message =
                            await Provider.of<AuthenticationService>(context,
                                    listen: false)
                                .login(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          Provider.of<NavigationService>(context, listen: false)
                              .goMenuPage();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      } else {
                        passwordController.text = "";
                        password = "";
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final message =
                            await Provider.of<AuthenticationService>(context,
                                    listen: false)
                                .registration(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          Provider.of<NavigationService>(context, listen: false)
                              .goMenuPage();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      } else {
                        passwordController.text = "";
                        password = "";
                      }
                    },
                    child: const Text('Registeration'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
