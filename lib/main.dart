import 'package:chatters/API/api.dart';
import 'package:chatters/Screens/auth/sign_in.dart';
import 'package:chatters/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

APIs obj = APIs();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await _initializeFiebase();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//         title: 'Chatter',
//         theme: ThemeData(
//           useMaterial3: false,
//           appBarTheme: const AppBarTheme(
//               centerTitle: true,
//               elevation: 1,
//               titleTextStyle: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 19),
//               backgroundColor: Colors.white,
//               iconTheme: IconThemeData(color: Colors.black)),
//         ),
//         home: const SplashScreen());
//   }
// }

Future<void> _initializeFiebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => obj),
      ],
      child: MaterialApp(
        title: 'Chatter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 1,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 19),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black)),
        ),
        home: FutureBuilder(
          // Wait for Firebase initialization to complete
          future: _initializeFiebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Check the user state and build the appropriate screen
              return APIs.auth.currentUser != null
                  ? const HomeScreen()
                  : const SignInPage();
            } else {
              // Show a loading indicator while waiting for initialization
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
