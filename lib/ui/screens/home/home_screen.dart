import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/home/home_bloc.dart';
import '../../widgets/appbar_custom.dart';
import '../../widgets/loading_center.dart';
import '../../widgets/popup_info.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translator = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        if (!didPop) PopupInfo.handleExitApp(context);
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const CustomAppbar(title: 'HOME'),
        // Change to BlocConsumer if bloc listeners are needed.
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, homeState) {
            if (homeState.status == HomeStatus.loading) {
              return LoadingCenter(text: translator.loadingUser);
            }
            return HomeBody(user: homeState.user!);
          },
        ),
      ),
    );
  }
}
