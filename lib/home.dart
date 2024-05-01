import "dart:convert";
import "dart:ui";
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import "package:weather_app/additional_info.dart";
import "package:weather_app/hourly_infor.dart";
import "package:weather_app/theme/theme_provider.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  bool isDark = false;
  int count = 1;
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Jabalpur';
      final res = await http.get(
        Uri.parse(
         {Your API HERE}      
    ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      weather = getCurrentWeather();
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeatherApp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              setState(() {
                count++;
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              });
            },
            icon: count % 2 == 1
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          )
        ],
      ),
      // ignore: prefer_const_constructors
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            if (count % 2 == 1) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 0, 0),
                strokeWidth: 10,
              ));
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 255, 255),
                strokeWidth: 10,
              ));
            }
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final ctempdata = data['list'];

          final ctemp = (ctempdata[0]["main"]["temp"]-273.73).toStringAsFixed(2);
          final ctempicon = ctempdata[0]["weather"][0]["main"];
          final pressure = ctempdata[0]["main"]["pressure"];
          final humidity = ctempdata[0]["main"]["humidity"];
          final windSpeed = ctempdata[0]["wind"]["speed"];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //Main Card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Column(
                            children: [
                              Text(
                                '$ctemp C',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              Icon(
                                (ctempicon == "Clouds") || (ctempicon == "Rain")
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 80,
                              ),
                              Text(
                                ctempicon,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //weather card
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Weather Forecast",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlySky =
                            data['list'][index + 1]['weather'][0]['main'];
                        final hourlyTemp =
                           ( hourlyForecast['main']['temp']-273.73).toStringAsFixed(2);
                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return Hourly(
                          samay: DateFormat.j().format(time),
                          value: hourlyTemp,
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      },
                    ),
                  ),

                  //ADDITIONAL INFO
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          "Additional Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AdditionalInfo(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: humidity.toString(),
                        ),
                        AdditionalInfo(
                          icon: Icons.air_sharp,
                          label: "Wind Speed",
                          value: windSpeed.toString(),
                        ),
                        AdditionalInfo(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: pressure.toString(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
