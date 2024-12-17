
import 'package:appteslo/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:appteslo/config/config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // esta es una llamada a una variable de entorno
  await Environment.initEnviroment();
  runApp(
   const    ProviderScope(child:  MainApp()
      ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Environment.apiUrl);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
