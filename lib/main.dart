import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:weather_app/home.dart";
import "package:weather_app/theme/theme_provider.dart";
void main()
{
  runApp(ChangeNotifierProvider(
    create: (context)=>ThemeProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme, 
      home: const WeatherScreen(),
    );
  }
}
