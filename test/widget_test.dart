import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:halisaha_yonetim/main.dart';

void main() {

  testWidgets('Uygulama açılıyor mu?', (WidgetTester tester) async {


    await tester.pumpWidget(
      const HalisahaApp(),
    );


    expect(
      find.byType(MaterialApp),
      findsOneWidget,
    );


  });

}