import 'package:flutter/material.dart';
import 'package:medecineapp/screens/home/optionMedecin/calendar.dart';
import 'package:medecineapp/screens/home/optionMedecin/db.dart';
import 'package:medecineapp/screens/home/optionMedecin/theme.dart';
import 'package:provider/provider.dart';

class Agenda extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.isDarkTheme ? dark : light,
          home: Calendar(),
        );
      }),
    );
  }
}
