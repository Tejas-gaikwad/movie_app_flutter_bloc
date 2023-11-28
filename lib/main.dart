import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/service/service.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

import 'constants/server_config.dart';
import 'home/dashboard.dart';

void main() {
  runZonedGuarded(() {
    initService();
    // initRepo();
    apiService.init(baseUrl: ServerConfig.baseUrl);
    Bloc.observer = TalkerBlocObserver();
    runApp(const MyApp());
  }, (error, stack) {
    debugPrint("Error: $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoard(),
    );
  }
}
