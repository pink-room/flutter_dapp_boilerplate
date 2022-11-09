import 'package:flutter/material.dart';
import 'package:flutter_dapp_boilerplate/providers/stateprovider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Provider.of<StateProvider>(context, listen: false)
                      .login(context);
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
