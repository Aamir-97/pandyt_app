class Sys {
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  @override
  String toString() {
    return 'Sys(country: $country, sunrise: $sunrise, sunset: $sunset)';
  }

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    country: json['country'] as String?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}
