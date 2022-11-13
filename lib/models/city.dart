part of 'models.dart';


class City extends Equatable {
  final String? cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const City({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  City copyWith({
    String? cityId,
    String? provinceId,
    String? province,
    String? type,
    String? cityName,
    String? postalCode,
  }) {
    return City(
      cityId: cityId ?? this.cityId,
      provinceId: provinceId ?? this.provinceId,
      province: province ?? this.province,
      type: type ?? this.type,
      cityName: cityName ?? this.cityName,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      cityId,
      provinceId,
      province,
      type,
      cityName,
      postalCode,
    ];
  }
}
