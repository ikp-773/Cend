import 'Providers/avatar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'Providers/endpoints.dart';
import 'Providers/files.dart';
import 'Providers/transfer.dart';
import 'Providers/user.dart';
import 'Services/global.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User("cend user"),
        ),
        ChangeNotifierProvider.value(
          value: Avatar('assets/avatar/Boy1.png'),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cend',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF2BCF6C),
          accentColor: Colors.lightGreenAccent,
        ),
        navigatorKey: RouteWay.navKey,
        initialRoute: RouteWay.splash,
        onGenerateRoute: RouteWay.routes,
      ),
    );
  }
}
