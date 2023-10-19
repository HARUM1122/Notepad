import 'package:flutter/material.dart';
import 'package:notepad/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProv, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProv.themeMode,
            theme: themeProv.lightTheme(),
            darkTheme: themeProv.darkTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
