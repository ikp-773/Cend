import 'dark.dart';
import 'package:cend/avatar.dart';
import 'package:flutter/material.dart';
import 'endpoints.dart';
import 'files.dart';
import 'transfer.dart';
import 'user.dart';
import 'global.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User("cend user"),
        ),
        ChangeNotifierProvider.value(
          value: Avatar('assets/Boy1.png'),
        ),
        ChangeNotifierProvider.value(
          value: Endpoints(),
        ),
        ChangeNotifierProvider.value(
          value: Files(),
        ),
        ChangeNotifierProvider.value(
          value: Transfer(),
        ),
        ChangeNotifierProvider.value(
          value: Dark(false),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cend',
        theme: Provider.of<Dark>(context).dark
            ? ThemeData.dark().copyWith(
                primaryColor: Color(0xFF2BCF6C),
              )
            : ThemeData.light(),
        navigatorKey: Router.navKey,
        initialRoute: Router.splash,
        onGenerateRoute: Router.routes,
      ),
    );
  }
}
