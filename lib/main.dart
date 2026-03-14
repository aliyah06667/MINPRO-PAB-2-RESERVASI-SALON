import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/login_page.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Beauti-Fy Salon',

          themeMode: currentMode,

          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: "Poppins",
            scaffoldBackgroundColor: const Color(0xFFFFF6F8),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFE91E63),
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: "Poppins",
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFE91E63),
              brightness: Brightness.dark,
            ),
          ),

          home: const LoginPage(),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Beauti-Fy Salon',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: "Poppins",
//         scaffoldBackgroundColor: const Color(0xFFFFF6F8),

//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFFFFB6C1),
//         ),

//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE91E63), width: 1),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE91E63), width: 2),
//           ),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }