part of '../models.dart';

class Cost extends Equatable {
  final int? value;
  final String? etd;
  final String? note;

  const Cost({this.value, this.etd, this.note});

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        value: json['value'] as int?,
        etd: json['etd'] as String?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  Cost copyWith({
    int? value,
    String? etd,
    String? note,
  }) {
    return Cost(
      value: value ?? this.value,
      etd: etd ?? this.etd,
      note: note ?? this.note,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [value, etd, note];
}
