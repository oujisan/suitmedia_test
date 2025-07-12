import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'package:suitmedia_test/views/first_screen.dart';
import 'package:suitmedia_test/views/second_screen.dart';
import 'package:suitmedia_test/views/third_screen.dart';

import 'package:suitmedia_test/viewmodels/first_viewmodel.dart';
import 'package:suitmedia_test/viewmodels/third_viewmodel.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MainApp(),
      defaultDevice: Devices.android.samsungGalaxyS25,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirstViewModel()),
        ChangeNotifierProvider(create: (_) => ThirdViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/firstScreen',
        routes: {
          '/firstScreen': (context) => FirstScreen(),
          '/secondScreen': (context) => SecondScreen(),
          '/thirdScreen': (context) => ThirdScreen(),
        },
        theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
      ),
    );
  }
}
