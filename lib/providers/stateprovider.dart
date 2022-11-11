// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class StateProvider extends ChangeNotifier {
  // Create a connector
  // final connector = WalletConnect(
  //   bridge: 'https://bridge.walletconnect.org',
  //   clientMeta: const PeerMeta(
  //     name: 'WalletConnect',
  //     description: 'WalletConnect Developer App',
  //     url: 'https://walletconnect.org',
  //     icons: [
  //       'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //     ],
  //   ),
  // );
  // String walletAddress = '';

  Future<void> login(context) async {
    // // Subscribe to events
    // connector.on(
    //     'connect', (session) => Navigator.of(context).pushNamed('home'));
    // connector.on('session_update', (payload) => print(payload));
    // connector.on('disconnect', (session) => print(session));

    // // Create a new session
    // if (!connector.connected) {
    //   final session = await connector.createSession(onDisplayUri: (uri) async {
    //     await launchUrlString(uri, mode: LaunchMode.externalApplication);
    //   });
    //   walletAddress = session.accounts[0];
    // } else {
    //   Navigator.of(context).pushNamed('home');
    // }
    Navigator.of(context).pushNamed('home');
  }

  Future<void> logout(context) async {
    // await connector.killSession();
    // walletAddress = '';
    if (ModalRoute.of(context)!.settings.name != 'login') {
      Navigator.of(context).pop();
    }
    print("Disconnnect");
  }
}
