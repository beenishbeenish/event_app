import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/comments_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/greeting_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'Provider/data_class.dart';
import 'Views/splash_screen.dart';

///Todo: Uncomment firebase and implement socail login's
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Todo: Uncomment firebase and implement socail login's
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return (MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => GreetingClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JSTPRTY',
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: kColorPrimary,
              ),
        ),
        home: const SplashScreen(),
      ),
    ));
    // return ChangeNotifierProvider(
    //   create: (context) => DataClass(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.grey,
    //     ),
    //     home: const SplashScreen(),
    //   ),
    // );
  }
}
