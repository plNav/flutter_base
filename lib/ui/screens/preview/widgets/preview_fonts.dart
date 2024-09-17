import 'package:flutter/material.dart';

import '../../../../data/enum/responsive_layout_font.dart';
import '../../../widgets/appbar_custom.dart';
import '../../../widgets/responsive_layout.dart';

class FontPreview extends StatelessWidget {
  const FontPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppbar(title: 'Font Preview'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Headlines', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text('Headline Large', style: textTheme.headlineLarge),
              Text('Headline Medium', style: textTheme.headlineMedium),
              Text('Headline Small', style: textTheme.headlineSmall),
              const SizedBox(height: 16),

              const Text('Titles', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text('Title Large', style: textTheme.titleLarge),
              Text('Title Medium', style: textTheme.titleMedium),
              Text('Title Small', style: textTheme.titleSmall),
              const SizedBox(height: 16),

              const Text('Bodies', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text('Body Large', style: textTheme.bodyLarge),
              Text('Body Medium', style: textTheme.bodyMedium),
              Text('Body Small', style: textTheme.bodySmall),
              const SizedBox(height: 16),

              /// Displays text with the responsive font sizes determined by [RLayout.rStyle].
              ///
              /// Possible Outputs:
              /// - For **Large Font (Responsive)**:
              ///   - **Desktop**: Uses `headlineLarge` from the theme (e.g., large font for big screens).
              ///   - **Tablet**: Uses `titleLarge` from the theme (e.g., slightly smaller font for medium screens).
              ///   - **Mobile**: Uses `bodyLarge` from the theme (e.g., default font size for mobile screens).
              ///
              /// - For **Medium Font (Responsive)**:
              ///   - **Desktop**: Uses `headlineMedium` from the theme (e.g., medium font for big screens).
              ///   - **Tablet**: Uses `titleMedium` from the theme (e.g., default title font for medium screens).
              ///   - **Mobile**: Uses `bodyMedium` from the theme (e.g., default font for mobile screens).
              ///
              /// - For **Small Font (Responsive)**:
              ///   - **Desktop**: Uses `headlineSmall` from the theme (e.g., small font for big screens).
              ///   - **Tablet**: Uses `titleSmall` from the theme (e.g., smaller font for medium screens).
              ///   - **Mobile**: Uses `bodySmall` from the theme (e.g., smaller font for mobile screens).
              const Text('Responsive Fonts (RLayout.rStyle)',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text('Large Font (Responsive)',
                  style: RLayout.rStyle(context: context, type: RLayoutFont.large)),
              Text('Medium Font (Responsive)',
                  style: RLayout.rStyle(context: context, type: RLayoutFont.medium)),
              Text('Small Font (Responsive)',
                  style: RLayout.rStyle(context: context, type: RLayoutFont.small)),
            ],
          ),
        ),
      ),
    );
  }
}
