// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

// import 'package:web3_connect/src/wallet_connect.dart';
class StateProvider extends ChangeNotifier {
  String account = '';
  late WalletConnect connector;
  late SessionStatus? session;

  Future<void> login(context) async {
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );

    connector.on('connect', (session) {
      print(session);
      Navigator.of(context).pushNamed('home');
    });
    connector.on('session_update', (payload) => print(payload));
    connector.on('disconnect', (session) {
      print(session);
      Navigator.of(context).pushNamed('login');
    });

    if (!connector.connected) {
      session = await connector.createSession(
          chainId: 5, onDisplayUri: (uri) async => await launchUrlString(uri));
    }
    account = session!.accounts[0];
    if (account != "") {
      //final client = Web3Client(rpcUrl, Client());
      //yourContract = YourContract(address: contractAddr, client: client);
    }
  }

  Future<void> logout(context) async {
    await connector.killSession();
    Navigator.of(context).pop();
  }
}
