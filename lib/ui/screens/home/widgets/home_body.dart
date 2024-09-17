import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/model/user.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../navigation/paths.dart';
import '../../../widgets/button_custom.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.user
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    final translator = AppLocalizations.of(context)!;
    const buttonsWidth = 300.0;
    const buttonsHeight = 75.0;
    const buttonsContentSeparator = SizedBox(width: 4.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(),
        Text(user.toString()),
        CustomButton(
          onPressed: () => homeBloc.add(ClearStorageEvent()),
          isError: true,
          fixedWidth: buttonsWidth,
          fixedHeight: buttonsHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cleaning_services, size: 18.0),
              buttonsContentSeparator,
              Text(translator.buttonClearStorage),
            ],
          ),
        ),
        CustomButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(preview),
          fixedWidth: buttonsWidth,
          fixedHeight: buttonsHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(translator.buttonPreview),
              buttonsContentSeparator,
              const Icon(Icons.navigate_next_sharp),
            ],
          ),
        ),
        const SizedBox(),
        const Row(),
      ],
    );
  }
}