import 'package:chatters/core/network.dart';
import 'package:chatters/core/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatters/Screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() {
    final UserRepository userRepository = UserRepository(
    userApiClient: UserApiClient(
      httpClient: http.Client(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFiebase();
    runApp(MyApp(
    userRepository: userRepository,
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userRepository});
  final UserRepository userRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Chatter',
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
        home:  SplashScreen(userRepository: userRepository,));
  }
}

_initializeFiebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
