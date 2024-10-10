class WeatherInfoModel {
  String temp;
  String humidity;
  String speed;

  WeatherInfoModel(
      {required this.temp, required this.humidity, required this.speed});

  WeatherInfoModel.fromJson(Map<String, dynamic> json)
      : temp = json['main']['temp'].toString(),
        humidity = json['main']['humidity'].toString(),
        speed = json['wind']['speed'].toString();
}
