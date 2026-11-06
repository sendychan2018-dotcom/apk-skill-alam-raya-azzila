// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alam_raya_azzila/app.dart';

void main() {
  testWidgets('logout asks for confirmation and returns to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AlamRayaApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Keluar'));
    await tester.pumpAndSettle();
    expect(find.text('Keluar dari akun?'), findsOneWidget);

    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Keluar'), findsOneWidget);

    await tester.tap(find.byTooltip('Keluar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Keluar'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke akun Anda'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.byTooltip('Keluar'), findsNothing);
  });

  testWidgets('registration creates a temporary account that can log in', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AlamRayaApp());

    await tester.ensureVisible(find.text('Daftar'));
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Bergabung dengan Alam Raya Azzila'), findsOneWidget);

    Future<void> enterRegistrationField(String key, String value) async {
      final field = find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(TextFormField),
      );
      await tester.ensureVisible(field);
      await tester.enterText(field, value);
    }

    await enterRegistrationField('registration-name', 'Siti Pemain');
    await enterRegistrationField(
      'registration-identifier',
      'siti.pemain@example.com',
    );
    await enterRegistrationField('registration-password', 'rahasia123');
    await enterRegistrationField('registration-confirm-password', 'rahasia123');

    await tester.ensureVisible(find.text('DAFTAR SEKARANG'));
    await tester.tap(find.text('DAFTAR SEKARANG'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke akun Anda'), findsOneWidget);
    expect(
      tester
          .widget<TextFormField>(find.byType(TextFormField).first)
          .controller
          ?.text,
      'siti.pemain@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'rahasia123');
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Siti Pemain 👋'), findsOneWidget);
  });

  testWidgets('login opens the dashboard with valid credentials', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AlamRayaApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Dasbor'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);

    await tester.tap(find.text('Pemain').last);
    await tester.pumpAndSettle();
    expect(find.text('Data Pemain'), findsOneWidget);

    await tester.tap(find.text('Nilai').last);
    await tester.pumpAndSettle();
    expect(find.text('Perkembangan Skill'), findsOneWidget);

    await tester.tap(find.text('Berita').last);
    await tester.pumpAndSettle();
    expect(find.text('Berita'), findsWidgets);

    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();
    expect(find.text('Lihat detail profil'), findsOneWidget);
  });
}
