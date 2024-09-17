import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/enum/settings_option.dart';
import '../../data/enum/supported_locale.dart';
import '../bloc/theme/theme_bloc.dart';
import 'popup_info.dart';

/// Uses [ThemeBloc] to dynamically change [Locale] and [Theme]
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.onBackPressed});

  final String title;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final translator = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(title, key: const Key('AppBar Title')),
      automaticallyImplyLeading: false,
      leading: onBackPressed == null
          ? null
          : IconButton(onPressed: () => onBackPressed!(), icon: const Icon(Icons.arrow_back)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PopupMenuButton<SettingsOption>(
            key: const Key('Settings Button'),
            icon: const Icon(Icons.settings),
            onSelected: (SettingsOption option) {
              if (option == SettingsOption.theme) {
                themeBloc.add(ToggleSchemaEvent());
              }
              if (option == SettingsOption.exit) {
                PopupInfo.handleExitApp(context);
              }
              // No action required for language option since the popup menu will handle it
            },
            itemBuilder: (context) => [
              // Locale Option with Current Language (Non-clickable)
              PopupMenuItem<SettingsOption>(
                enabled: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translator.language,
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    _buildLanguageMenu(context),
                  ],
                ),
              ),
              // Theme Option with Current Icon
              PopupMenuItem<SettingsOption>(
                key: const Key('Change Theme Setting'),
                value: SettingsOption.theme,
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  buildWhen: (previous, current) => previous.themeMode != current.themeMode,
                  builder: (context, themeState) {
                    final isLightMode = themeState.themeMode == ThemeMode.light;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translator.theme),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Icon(isLightMode ? Icons.light_mode : Icons.dark_mode),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Exit Option
              PopupMenuItem<SettingsOption>(
                key: const Key('Exit Setting'),
                value: SettingsOption.exit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(translator.exit),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Icon(Icons.exit_to_app, color: colorScheme.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the language selection menu inside the disabled PopupMenuItem.
  _buildLanguageMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, themeState) {
        final currentLocale = SupportedLocale.fromLocale(themeState.locale!);
        return PopupMenuButton<SupportedLocale>(
          key: const Key('Change Locale Setting'),
          onSelected: (SupportedLocale selectedLocale) =>
              themeBloc.add(ChangeLocaleEvent(locale: selectedLocale)),
          itemBuilder: (context) => SupportedLocale.values
              .map((locale) => PopupMenuItem<SupportedLocale>(
                    value: locale,
                    child: Text(locale.name.toUpperCase()),
                  ))
              .toList(),
          child: Row(
            children: [
              Text(
                currentLocale.name.toUpperCase(),
                style: TextStyle(color: colorScheme.onSurface),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
