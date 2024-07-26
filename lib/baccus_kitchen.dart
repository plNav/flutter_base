import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/dio/dio_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_login_repository.dart';
import 'package:baccus_kitchen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaccusKitchen extends StatelessWidget {
  const BaccusKitchen({super.key});

  @override
  Widget build(BuildContext context) {
    final localRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => LocalLoginRepository()),
    ];
    final dioRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => DioLoginRepository()),
    ];

    return MultiRepositoryProvider(
      providers: isLocalMode ? localRepos : dioRepos,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SizedBox()),
    );
  }
}
