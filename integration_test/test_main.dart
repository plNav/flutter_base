import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_login_repository.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/navigation/routes.dart';
import 'package:baccus_kitchen/ui/theme/schema/dark/dark_theme.dart';
import 'package:baccus_kitchen/ui/theme/schema/light/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BaccusKitchenTest extends StatelessWidget {
  final bool isDebugBannerShown;

  const BaccusKitchenTest({super.key, this.isDebugBannerShown = false});

  @override
  Widget build(BuildContext context) {
    final localRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => LocalLoginRepository()),
    ];

    return MultiRepositoryProvider(
      providers: localRepos,
      child: MaterialApp(
        title: 'Baccus Kitchen Test',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        debugShowCheckedModeBanner: isDebugBannerShown,
        themeMode: ThemeMode.dark,
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: Routes.routes,
        initialRoute: login,
      ),
    );
  }
}
