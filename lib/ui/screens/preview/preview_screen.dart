import 'package:flutter/material.dart';

import '../../widgets/appbar_custom.dart';
import '../../widgets/button_custom.dart';
import 'widgets/preview_colors.dart';
import 'widgets/preview_fonts.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    const buttonsWidth = 400.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppbar(title: 'Font Preview'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            text: 'Font Preview',
            fixedWidth: buttonsWidth,
            onPressed: () => navigator.push(
              MaterialPageRoute(builder: (context) => const FontPreview()),
            ),
          ),
          CustomButton(
            text: 'Color Preview',
            fixedWidth: buttonsWidth,
            onPressed: () => navigator.push(
              MaterialPageRoute(builder: (context) => const ColorPreview()),
            ),
          ),
          const Row(),
        ],
      ),
    );
  }
}
