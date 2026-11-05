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
