import 'package:flutter/material.dart';

import '../../../widgets/appbar_custom.dart';

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppbar(title: 'Font Preview'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Primary Colors', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              _buildColorCircle(context, 'Primary', colorScheme.primary),
              _buildColorCircle(context, 'On Primary', colorScheme.onPrimary),
              _buildColorCircle(context, 'Primary Container', colorScheme.primaryContainer),
              const SizedBox(height: 16),

              const Text('Secondary Colors', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              _buildColorCircle(context, 'Secondary', colorScheme.secondary),
              _buildColorCircle(context, 'On Secondary', colorScheme.onSecondary),
              _buildColorCircle(context, 'Secondary Container', colorScheme.secondaryContainer),
              const SizedBox(height: 16),

              const Text('Surface & Error Colors', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              _buildColorCircle(context, 'Surface', colorScheme.surface),
              _buildColorCircle(context, 'On Surface', colorScheme.onSurface),
              _buildColorCircle(context, 'Error', colorScheme.error),
              const SizedBox(height: 16),

              const Text('Tertiary Colors', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              _buildColorCircle(context, 'Tertiary', colorScheme.tertiary),
              _buildColorCircle(context, 'On Tertiary', colorScheme.onTertiary),
              _buildColorCircle(context, 'Tertiary Container', colorScheme.tertiaryContainer),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to build a CircleAvatar for each color.
  Widget _buildColorCircle(BuildContext context, String label, Color color) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: surfaceColor, width: 3),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}