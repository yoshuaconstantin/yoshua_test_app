// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yoshua_ui_test/main.dart';
import 'package:yoshua_ui_test/module/login/bloc/login_bloc.dart';
import 'package:yoshua_ui_test/module/login/login_page.dart';

void main() {
  testWidgets('membuka halaman login', (tester) async {
    var loginBloc = LoginBloc();
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => loginBloc,
        child: const LoginPage(),
      ),
    ));
    expect(find.text('username'), findsOneWidget);
    await tester.pump(Duration(seconds: 75));
  });
}
