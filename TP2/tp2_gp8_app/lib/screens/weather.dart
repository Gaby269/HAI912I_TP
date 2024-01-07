import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tp2_appli_meteo/screens/weather_model.dart';
import 'package:tp2_appli_meteo/styles/styles.dart';
import 'package:tp2_appli_meteo/styles/texts.dart';
import 'package:tp2_appli_meteo/styles/colors.dart';
import 'package:http/http.dart' as http; // Importez le package http
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Classe pour gérer les appels réseau
class Network {
  final String apiKey;

  Network(this.apiKey);

  Future<WeatherModel> getWeather({required String cityName}) async {
    var finalUrl =
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey";

    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("La ville n'existe pas !");
    }
  }
}

// Widget principal de l'application météo
class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  final Network _network = Network("aa205904f5d69b07e57eebfb78bc6e8f");

  Future<WeatherModel>? _weatherDataFuture;

  List<Map<String, dynamic>>? futureDayData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: meteoText,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: 'Ville...',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Appel la fonction fetchWeatherData dans weatherDataFuture pour l'utiliser
                    setState(() {
                      _weatherDataFuture =
                          _fetchWeatherData(_cityController.text);
                    });

                    // Efface le contenu du champ de texte
                    _cityController.clear();
                  },
                  icon: rechercheIcon,
                  label: rechercheText,
                  style: ElevatedButton.styleFrom(
                    primary: fushia, // Couleur du bouton
                  ),
                ),
              ],
            ),
          ),
          espaceVFixe20,
          // Afficher les informations du jour
          FutureBuilder<WeatherModel>(
            future: _weatherDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else if (snapshot.hasData) {
                WeatherModel weatherData = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${weatherData.city!.name}', style: textVilleStyle),
                    // Prenons la date formater pour pour pouvoir avoir le jour
                    Text(_formattedDate(weatherData.list![0].dt!),
                        style: textDateStyle),
                    espaceVFixe50,
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      getWeatherIcon(
                                          weatherDescription: "Temperature",
                                          color: fushia,
                                          size: 40.0),
                                      espaceHFixe5,
                                      Text(
                                          '${(weatherData.list![0].main!.temp! - 273.15).toInt()}°C',
                                          style: textTempStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          espaceHFixe50,
                          getWeatherIcon(
                              weatherDescription:
                                  weatherData.list![0].weather![0].main!,
                              color: fushiaGrey,
                              size: 120.0),
                        ],
                      ),
                    ),
                    espaceVFixe30,
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  getWeatherIcon(
                                      weatherDescription: "sunRise",
                                      color: fushia,
                                      size: 20.0),
                                  espaceHFixe5,
                                  Text(
                                      _formattedTime(
                                          weatherData.city!.sunrise!),
                                      style: textWeatherCurrentStyle),
                                ],
                              ),
                              espaceVFixe10,
                              Row(
                                children: [
                                  getWeatherIcon(
                                      weatherDescription: "sunSet",
                                      color: fushia,
                                      size: 20.0),
                                  espaceHFixe5,
                                  Text(
                                      _formattedTime(weatherData.city!.sunset!),
                                      style: textWeatherCurrentStyle),
                                ],
                              ),
                            ],
                          ),
                          espaceHFixe10,
                          Container(
                            width: 2.0, // Largeur de la barre
                            color: fushia, // Couleur de la barre
                            height: 50.0, // Hauteur de la barre
                          ),
                          espaceHFixe10,
                          Column(
                            children: [
                              Row(
                                children: [
                                  getWeatherIcon(
                                      weatherDescription: "Humidity",
                                      color: fushia,
                                      size: 20.0),
                                  espaceHFixe5,
                                  Text(
                                      '${weatherData.list![0].main!.humidity!}%',
                                      style: textWeatherCurrentStyle),
                                ],
                              ),
                            ],
                          ),
                          espaceHFixe10,
                          Container(
                            width: 2.0, // Largeur de la barre
                            color: fushia, // Couleur de la barre
                            height: 50.0, // Hauteur de la barre
                          ),
                          espaceHFixe10,
                          Column(
                            children: [
                              Row(
                                children: [
                                  getWeatherIcon(
                                      weatherDescription: "Wind",
                                      color: fushia,
                                      size: 20.0),
                                  espaceHFixe5,
                                  Text(
                                      '${convertMphToKph(weatherData.list![0].wind!.speed!)} km/h',
                                      style: textWeatherCurrentStyle),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return aucunDonneeText;
              }
            },
          ),
        ],
      ),
      // Partie sur les jours suivants avec FutureBuilder
      bottomNavigationBar: FutureBuilder<WeatherModel>(
        future: _weatherDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return textVide; // pour rien afficher
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else if (snapshot.hasData) {
            WeatherModel weatherData = snapshot.data!;
            futureDayData = processWeatherData(weatherData.list!);

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (Map<String, dynamic> dailyData in futureDayData!)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  '${dailyData['day_of_week']}',
                                  style: textDayFutureStyle,
                                ),
                                espaceVFixe10,
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            getWeatherIcon(
                                                weatherDescription: 'arrowUp',
                                                color: fushia,
                                                size: 15.0),
                                            espaceHFixe5,
                                            Text(
                                              '${(dailyData['temperature_max'] - 273.15).toInt()}°C',
                                              style: textWeatherFutureStyle,
                                            ),
                                          ],
                                        ),
                                        espaceVFixe3,
                                        Row(
                                          children: [
                                            getWeatherIcon(
                                                weatherDescription: 'arrowDown',
                                                color: fushia,
                                                size: 15.0),
                                            espaceHFixe5,
                                            Text(
                                              '${(dailyData['temperature_min'] - 273.15).toInt()}°C',
                                              style: textWeatherFutureStyle,
                                            ),
                                          ],
                                        ),
                                        espaceVFixe3,
                                        Row(
                                          children: [
                                            getWeatherIcon(
                                                weatherDescription: 'Humidity',
                                                color: fushia,
                                                size: 15.0),
                                            espaceHFixe5,
                                            Text(
                                              '${dailyData['humidity']}%',
                                              style: textWeatherFutureStyle,
                                            ),
                                          ],
                                        ),
                                        espaceVFixe3,
                                        Row(
                                          children: [
                                            getWeatherIcon(
                                                weatherDescription: 'Wind',
                                                color: fushia,
                                                size: 15.0),
                                            espaceHFixe5,
                                            Text(
                                              '${convertMphToKph(dailyData['wind_speed'])} km/h',
                                              style: textWeatherFutureStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    espaceHFixe5,
                                    getWeatherIcon(
                                        weatherDescription:
                                            dailyData['weather'],
                                        color: fushia,
                                        size: 40.0),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return textVide;
          }
        },
      ),
    );
  }

  // _fetchWeatherData pour charger les données
  Future<WeatherModel> _fetchWeatherData(String cityName) async {
    if (cityName.isNotEmpty) {
      try {
        WeatherModel currentWeather =
            await _network.getWeather(cityName: cityName);

        print(currentWeather.list!);

        // On ajoute les vérifications pour les variables null
        if (currentWeather.list != null && currentWeather.list!.isNotEmpty) {
          final firstWeatherList = currentWeather.list![0];

          if (firstWeatherList.dt != null &&
              firstWeatherList.weather != null &&
              firstWeatherList.weather!.isNotEmpty &&
              firstWeatherList.weather![0].main != null &&
              firstWeatherList.main != null &&
              firstWeatherList.main!.temp != null &&
              firstWeatherList.main!.humidity != null) {
            return currentWeather;
          } else {
            throw Exception("Données météorologiques incomplètes ou null");
          }
        } else {
          throw Exception("Données météorologiques null ou vides");
        }
      } catch (error, stackTrace) {
        print(
            "Erreur lors de la récupération des données météorologiques actuelles: $error");
        print(error.toString());
        print("StackTrace: $stackTrace");
        throw error;
      }
    } else {
      throw Exception("Veuillez entrer une ville.");
    }
  }

  // Formater la date
  String _formattedDate(int timestamp) {
    // Convertissez le timestamp en objet DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Formatez la date
    String formattedDate =
        DateFormat('EEEE, d MMM y', 'fr_FR').format(dateTime);

    return formattedDate;
  }

  String _formattedTime(int timestamp) {
    // Convertissez le timestamp en objet DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Formatez la date et l'heure
    String formattedDateTime = DateFormat('HH:mm', 'fr_FR').format(dateTime);

    return formattedDateTime;
  }

  // Convertisseur de mille par heure en kilometres par h
  double convertMphToKph(num mph) {
    // Facteur de conversion
    const double conversionFactor = 1.609344;

    // Calcul de la vitesse en km/h
    double kph = mph * conversionFactor;

    // Arrondir le résultat à deux chiffres après la virgule
    kph = double.parse((kph).toStringAsFixed(2));

    return kph;
  }

  // Recuperation des informations des jorus suivants utiles
  List<Map<String, dynamic>> processWeatherData(List<WeatherList> weatherList) {
    Map<int, Map<String, dynamic>> dailyData = {};

    for (int i = 1; i < weatherList.length; i++) {
      WeatherList currentWeather = weatherList[i];
      DateTime dateTime = DateTime.parse(currentWeather.dtTxt!);
      int day = DateTime(dateTime.year, dateTime.month, dateTime.day)
          .millisecondsSinceEpoch;
      print(day);

      // Extraire le jour de la semaine
      String dayOfWeek = DateFormat('EEEE', 'fr_FR').format(dateTime);

      if (!dailyData.containsKey(day)) {
        dailyData[day] = {
          'weather': currentWeather.weather![0].main!,
          'date': DateFormat('EEEE, d MMM y', 'fr_FR').format(dateTime),
          'temperature_min': currentWeather.main!.tempMin,
          'temperature_max': currentWeather.main!.tempMax,
          'humidity': currentWeather.main!.humidity,
          'wind_speed': currentWeather.wind!.speed,
          'day_of_week': capitalize(dayOfWeek),
        };
      } else {
        dailyData[day]!['temperature_min'] = min<num>(
          dailyData[day]!['temperature_min']!.toDouble(),
          currentWeather.main!.tempMin!.toDouble(),
        );
        dailyData[day]!['temperature_max'] = max<num>(
          dailyData[day]!['temperature_max']!.toDouble(),
          currentWeather.main!.tempMax!.toDouble(),
        );
      }
    }

    return dailyData.values.toList();
  }

  // Récuperer les icons
  Widget getWeatherIcon({
    required String weatherDescription,
    required Color color,
    required double size,
  }) {
    Widget icon;
    switch (weatherDescription) {
      case "Clear":
        icon = Icon(FontAwesomeIcons.sun, color: color, size: size);
        break;
      case "Clouds":
        icon = Icon(FontAwesomeIcons.cloud, color: color, size: size);
        return Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(child: icon),
        );
      case "Rain":
        icon = Icon(FontAwesomeIcons.cloudRain, color: color, size: size);
        break;
      case "Snow":
        icon = Icon(FontAwesomeIcons.snowman, color: color, size: size);
        break;
      case "Temperature":
        icon = Icon(FontAwesomeIcons.thermometerHalf, color: color, size: size);
        break;
      case "Wind":
        icon = Icon(FontAwesomeIcons.wind, color: color, size: size);
        break;
      case "Humidity":
        icon = Icon(FontAwesomeIcons.tint, color: color, size: size);
        break;
      case "arrowDown":
        icon = Icon(FontAwesomeIcons.arrowCircleDown, color: color, size: size);
        break;
      case "arrowUp":
        icon = Icon(FontAwesomeIcons.arrowCircleUp, color: color, size: size);
        break;
      case "sunRise":
        icon = Icon(FontAwesomeIcons.sun, color: color, size: size);
        break;
      case "sunSet":
        icon = Icon(FontAwesomeIcons.solidMoon, color: color, size: size);
        break;
      default:
        icon = Icon(FontAwesomeIcons.snowman, color: color, size: size);
        break;
    }
    return Center(child: icon);
  }

  // Mettre la premiere lettre de s en majuscule
  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }
}
