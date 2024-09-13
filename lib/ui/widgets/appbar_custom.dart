import 'package:baccus_kitchen/data/enum/supported_locale.dart';
import 'package:baccus_kitchen/ui/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isLightMode = themeState.themeMode == ThemeMode.light;
        final currentLocale = SupportedLocale.fromLocale(themeState.locale);
        return AppBar(
          title: Text(title),
          actions: [
            // TOGGLE COLOR SCHEME BUTTON
            IconButton(
              onPressed: () => themeBloc.add(ToggleSchemaEvent()),
              icon: Icon(isLightMode ? Icons.light_mode : Icons.dark_mode),
            ),
            // CHANGE LANGUAGE BUTTON
            PopupMenuButton<SupportedLocale>(
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
                  Text(currentLocale.name.toUpperCase()),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
