import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/ui/bloc/home/home_bloc.dart';
import 'package:baccus_kitchen/ui/widgets/appbar_custom.dart';
import 'package:baccus_kitchen/ui/widgets/loading_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'HOME'),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState.status == HomeStatus.loading) {
            return const LoadingCenter();
          }
          final User user = homeState.user!;
          return Center(child: Text(user.toString()));
        },
      ),
    );
  }
}
