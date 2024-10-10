class MarkerModel {
  String title;
  String snippet;
  double latitude;
  double longitude;

  MarkerModel({
    required this.title,
    required this.snippet,
    required this.latitude,
    required this.longitude,
  });

  factory MarkerModel.init() => MarkerModel(
      title: 'Test', snippet: 'Snip', latitude: 0.0, longitude: 0.0);

  MarkerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        snippet = json['snippet'].toString(),
        latitude = double.parse(json['latitude'].toString()),
        longitude = double.parse(json['longitude'].toString());

  Map<String, dynamic> toJson() => {
        'title': title,
        'snippet': snippet,
        'latitude': latitude,
        'longitude': longitude,
      };
}
