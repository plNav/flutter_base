import 'package:baccus_kitchen/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginScreen has working input fields and login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Define the finders
    final urlField = find.byType(TextField).at(0);
    final userField = find.byType(TextField).at(1);
    final passField = find.byType(TextField).at(2);
    final loginButton = find.byType(ElevatedButton);

    // Enter text into the text fields
    await tester.enterText(urlField, 'http://example.com');
    await tester.enterText(userField, 'username');
    await tester.enterText(passField, 'password');

    // Tap the login button
    await tester.tap(loginButton);

    // Rebuild the widget after the state has changed
    await tester.pump();

    // Verify that the text was entered correctly
    expect(find.text('http://example.com'), findsOneWidget);
    expect(find.text('username'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
  });
}
