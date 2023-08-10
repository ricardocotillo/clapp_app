import 'dart:convert';

import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/token.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/clubs.provider.dart';
import 'package:clapp/providers/home.provider.dart';
import 'package:clapp/providers/profile.provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'router.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('me');
  final userBox = Hive.box<User>('me');
  const storage = FlutterSecureStorage();
  final tokenString = await storage.read(key: 'token');
  final Token? token =
      tokenString != null ? Token.fromJson(jsonDecode(tokenString)) : null;
  final user = userBox.get(0);
  final userId = user?.id;
  runApp(MultiProvider(
    providers: [
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
              token: token,
              user: user,
            ),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          ChangeNotifierProvider<ClubsProvider>(
            create: (_) => ClubsProvider(
              filter: ClubFilter(members: userId != null ? [userId] : []),
            ),
          ),
        ],
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SportApp',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
