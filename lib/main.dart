import 'package:flutask/controllers/auth_controller.dart';
import 'package:flutask/controllers/language_controller.dart';
import 'package:flutask/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'controllers/theme_controller.dart';
import 'helpers/l10n/l10n.dart';
import 'views/loading.dart';
import 'views/login_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<LanguageController>(
            create: (_) => LanguageController()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: Consumer2<ThemeNotifier, LanguageController>(
          builder: (context, themeNotifier, languageController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FluTask App',
          theme: themeNotifier.darkTheme! ? dark : light,
          locale: languageController.locale,
          localizationsDelegates: [
            AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('bn'),
          ],

           routes: {
            '/': (context) => Router(),
            '/login': (context) => LogIn(),
            '/register': (context) => Register(),
            // '/password-reset': (context) => PasswordReset(),
          },
      
        );
      }),
    );
  }
}


class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Loading();
          case Status.Unauthenticated:
            return LogIn();
          // case Status.Authenticated:
          //   return ChangeNotifierProvider(
          //     create: (context) => TodoProvider(authProvider),
          //     child: Todos(),
          //   );
          default:
            return LogIn();
        }
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<String> _languagesListDefault = [
//     'English',
//     'Bangla',
//   ];

//   get languagesListDefault => _languagesListDefault;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Consumer(
//               builder: (context, ThemeNotifier themeNotifier, child) =>
//                   SwitchListTile(
//                 title: Text("Dark Mode"),
//                 onChanged: (val) {
//                   themeNotifier.toggleTheme();
//                 },
//                 value: themeNotifier.darkTheme!,
//               ),
//             ),
//             Consumer<LanguageController>(
//               builder: (context, languageController, child) {
//                 return Container(
//                   width: 100,
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   alignment: Alignment.centerLeft,
//                   decoration: BoxDecoration(
//                     color: Colors.indigo,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                   child: DropdownButton<String>(
//                     value: languageController.defineCurrentLanguage(context),
//                     icon: Icon(
//                       Icons.arrow_downward,
//                       color: Colors.white,
//                     ),
//                     iconSize: 20,
//                     elevation: 0,
//                     style: TextStyle(color: Colors.white),
//                     underline: Container(
//                       height: 1,
//                     ),
//                     dropdownColor: Colors.indigo,
//                     onChanged: (String? newValue) {
//                       languageController.changeLocale(newValue!);
//                     },
//                     items: languagesListDefault.map<DropdownMenuItem<String>>(
//                       (String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 30),
//             Text(
//               AppLocalization.of(context)!.translate('hello-world'),
//               style: TextStyle(color: Colors.indigo, fontSize: 30),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
