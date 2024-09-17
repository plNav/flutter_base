import 'package:flutter/material.dart';

import '../../data/enum/responsive_layout_font.dart';
import 'responsive_layout.dart';

class LoadingCenter extends StatelessWidget {
  const LoadingCenter({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(
              height: RLayout.rDouble(
            context: context,
            mobileMeasure: 20.0,
            tabletMeasure: 40.0,
            desktopMeasure: 60.0,
          )),
          Text(
            text,
            style: RLayout.rStyle(context: context, type: RLayoutFont.large),
          ),
        ],
      ),
    );
  }
}
