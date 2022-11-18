// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';

import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:android_intent/android_intent.dart';

class StateProvider extends ChangeNotifier {
  static const contractAddress = '0x996E04787e1430f4466fE6555a3a5F01879C6897';
  String account = '';
  late WalletConnect connector;
  late EthereumWalletConnectProvider provider;
  late SessionStatus? session;

  late Client httpClient;
  late Web3Client ethClient;

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

  void initWeb3() {
    provider = EthereumWalletConnectProvider(connector, chainId: 5);
    httpClient = Client();
    ethClient = Web3Client(
        "https://goerli.infura.io/v3/7ff7faedb05b4946a5af0faab118dea9",
        httpClient);
  }

  Future<DeployedContract> loadContract() async {
    String abiCode =
        await rootBundle.loadString("contracts/PeanutButterFactory.json");
    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "MetaCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> getJars() async {
    final contract = await loadContract();
    final ethFunction = contract.function('getJars');
    return await ethClient
        .call(contract: contract, function: ethFunction, params: []);
  }

  Future<List<dynamic>> getIngredients() async {
    final contract = await loadContract();
    final ethFunction = contract.function('getExtraIngredients');
    return await ethClient
        .call(contract: contract, function: ethFunction, params: []);
  }

  Future<String> createJar(selectedIngredient) async {
    DeployedContract contract = await loadContract();

    final ethFunction = contract.function('create');

    var tx = Transaction.callContract(
      contract: contract,
      function: ethFunction,
      parameters: [
        [selectedIngredient]
      ],
    );

    openWalletConnect();
    var result = await provider.sendTransaction(
      from: account,
      to: tx.to.toString(),
      value: BigInt.from(1000000000000000),
      data: tx.data,
    );
    print(result);
    return result;
  }

  openWalletConnect() async {
    if (Platform.isAndroid) {
      AndroidIntent intent =
          const AndroidIntent(action: 'action_view', data: 'wc://');
      await intent.launch();
    } else {
      if (await canLaunchUrl(Uri(scheme: 'wc'))) {
        await launchUrl(Uri(scheme: 'wc'));
      } else {
        throw 'Could not launch wc://';
      }
    }
  }
}
