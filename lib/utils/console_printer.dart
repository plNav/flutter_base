import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/responsive_layout.dart';

const String error = '\u001b[31;1m';
const String red = '\x1B[31m';

const String success = '\u001b[32;1m';
const String green = '\x1B[32m';

const String warning = '\u001b[33;1m';
const String yellow = '\x1B[33m';

const String purpleB = '\u001b[35;1m';
const String purple = '\x1B[35m';

const String blueB = '\u001b[34;1m';
const String blue = '\x1B[34m';

const String cyanB = '\u001b[36;1m';
const String cyan = '\x1B[36m';

const String end = '\x1B[0m';
const String symbols = '€!¡?¿@#%&*(){}-_=<>';

int count = 0;

///Show console msg with color. Only works on [kDebugMode]
///
///[color] constants declared in <b>utils > console_printer.dart</b>.
///[printLabel] default false, if true [printCWarning] before [msg].
printC(String color, String msg, {bool printLabel = false}) {
  if (kDebugMode) {
    if (printLabel) printCWarning();
    print('${count < 10 ? '0${count++}' : count++} $color $msg $end');
  }
}

///Show console msg with counter, color and Stacktrace.
///
///[color] constants declared in <b>utils > console_printer.dart</b>
printStacktrace(String color, String msg) {
  if (kDebugMode) {
    final body = '$color $msg $end';
    print('${count < 10 ? '0${count++}' : count++} $body ${StackTrace.current.toString()}');
  }
}

///Prints visible multiline WARNING with colors & stacktrace in console.
printCWarning() {
  if (kDebugMode) {
    print('\n');
    print('$warning*********************************$end');
    print('$warning**$error    *      WARNING      *   $end $warning**$end');
    print('$warning*********************************$end');
    print('\n');
    print(StackTrace.current.toString());
  }
}

///Shows different colors for [printC] and prints [printCWarning].
printCTest() {
  if (kDebugMode) {
    printCWarning();
    print('$error TE\$T $symbols ERROR $end');
    print('$success TE\$T $symbols SUCCESS $end');
    print('$warning TE\$T $symbols WARNING $end');
    print('$red TE\$T $symbols RED $end');
    print('$green TE\$T $symbols GREEN $end');
    print('$yellow TE\$T $symbols YELLOW $end');
    print('$blueB TE\$T $symbols BLUE_B $end');
    print('$blue TE\$T $symbols BLUE $end');
    print('$cyanB TE\$T $symbols CYAN_B $end');
    print('$cyan TE\$T $symbols CYAN $end');
    print('$purpleB TE\$T $symbols PURPLE_B $end');
    print('$purple TE\$T $symbols PURPLE $end');
    printCWarning();
  }
}

///Prints RLayout, Ratio, Width & Height for the currentScreen by [context] labelled by [widget].
void printCScreenSize(BuildContext context, String widget) {
  if (kDebugMode) {
    final size = MediaQuery.sizeOf(context);
    final String layout = RLayout.getLayoutName(context).name;
    print('\n');
    printC(blue, 'Widget Build [$widget] - RLayout [$layout]');
    printC(cyan, 'Ratio  => ${size.aspectRatio}');
    printC(cyan, 'Width  => ${size.width}');
    printC(cyan, 'Height => ${size.height}');
    print('\n');
  }
}

