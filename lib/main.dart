import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/stateprovider.dart';

import 'login.dart';
import 'home.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CartModel()),
//         Provider(create: (context) => SomeOtherClass()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Provider.of<StateProvider>(context, listen: false)
                .connector
                .connected
            ? 'home'
            : 'login',
        routes: {
          'login': (context) => const Login(title: 'Login'),
          'home': (context) => const Home(title: 'Home Page'),
        });
  }
}
