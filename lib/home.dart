import 'package:flutter/material.dart';
import 'package:flutter_dapp_boilerplate/providers/stateprovider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Consumer<StateProvider>(
              builder: (context, state, child) {
                return Text('Wallet address: ${state.walletAddress}');
              },
            ),
            TextButton(
                onPressed: () {
                  Provider.of<StateProvider>(context, listen: false)
                      .logout(context);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
