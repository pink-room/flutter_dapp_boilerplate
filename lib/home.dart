import 'package:flutter/material.dart';
import 'package:flutter_dapp_boilerplate/providers/stateprovider.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class ParsedJar {
  ParsedJar(this.extraIngredient, this.paidValue, this.creator);
  String extraIngredient;
  String paidValue;
  String creator;
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ParsedJar> jars = [];

  parseExtraIngredients(extraIngredients) {
    var splittedIngredients = extraIngredients
        .split(',')
        .where((ingredient) => ingredient != '')
        .join();
    return splittedIngredients;
  }

  setJars(newJars) {
    setState(() {
      newJars[0]
          .where((jar) => jar[0] != '')
          .forEach((jar) => jars.add(ParsedJar(
                parseExtraIngredients(jar[0]),
                '${EtherAmount.inWei(jar[1]).getInWei} wei',
                jar[2].toString(),
              )));
    });
  }

  @override
  initState() {
    super.initState();
    Provider.of<StateProvider>(context, listen: false).initWeb3();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFF333138),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 8.0),
                    child: Image.asset('assets/peanut_butter.png'),
                  ),
                  Container(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          Text(
                            Provider.of<StateProvider>(context, listen: false)
                                .account,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
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
                                      .logout(context);
                                },
                                child: const Text(
                                  'Kill Session',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ))
                ],
              )),
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
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        height: screenWidth * 0.4,
                        width: screenWidth * 0.4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color(0xFFe7a61a),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x11000000),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () =>
                              Provider.of<StateProvider>(context, listen: false)
                                  .getJars()
                                  .then((value) => setJars(value)),
                          child: const Text('get jars'),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(16.0),
                          height: screenWidth * 0.4,
                          width: screenWidth * 0.4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color(0xFFe7a61a),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x11000000),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    width: screenWidth,
                    height: screenHeight * 0.45,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: jars.isNotEmpty
                        ? ListView.builder(
                            // Let the ListView know how many items it needs to build.
                            itemCount: jars.length,
                            // Provide a builder function. This is where the magic happens.
                            // Convert each item into a widget based on the type of item it is.
                            itemBuilder: (context, index) {
                              final item = jars[index];
                              return ListTile(
                                title: Text(item.extraIngredient),
                                subtitle: Text(item.paidValue.toString()),
                                // subtitle: item,
                              );
                            },
                          )
                        : null,
                  ),
                ]),
              )),
        ],
      ),
      backgroundColor: const Color(0xFF333138),
    );
  }
}
