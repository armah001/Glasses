import 'package:flutter/material.dart';
import 'package:glassesrus/loginScreen.dart';
import 'package:glassesrus/product_provider.dart';
import 'package:glassesrus/splash_intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' GlassesRUs',
      debugShowCheckedModeBanner: false,
      home: /* MultiProvider(
        providers: [
          Provider<ProductProvider>(
            create: (ctx) => ProductProvider(),
          )
        ],
        child:*/
          StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Splash();

          /* if (snapshot.hasData) {

          } else {
            return LoginScreen();
          }*/
        },
        /* ),*/
      ),

      /* initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),

        //'/project': (context) => const ProjectView(),
        //'/search': (context) => const SearchPage(),
        //'/map': (context) => const Map(),
        //'/profile': (context) => const ProfilePage(),
        //'/resume': (context) => const ResumePage(),
      },*/
    );
  }
}
// flutter run --no-sound-null-safety
