// ignore_for_file: use_full_hex_values_for_flutter_colors
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StateProvider>(context, listen: false).logout(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFF333138),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(24.0),
              child: Image.asset('assets/peanut_butter.png'),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  color: Color(0xFFe7a61a),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome to',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          const Text('Whip & Slip',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 24)),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 10)),
                                onPressed: () {
                                  Provider.of<StateProvider>(context,
                                          listen: false)
                                      .login(context);
                                },
                                child: const Text(
                                  'Connect a Wallet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      backgroundColor: const Color(0xFF333138),
    );
  }
}
