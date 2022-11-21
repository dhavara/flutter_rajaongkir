part of '../models.dart';

class Costs extends Equatable {
  final String? service;
  final String? description;
  final List<Cost>? cost;

  const Costs({this.service, this.description, this.cost});

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        service: json['service'] as String?,
        description: json['description'] as String?,
        cost: (json['cost'] as List<dynamic>?)
            ?.map((e) => Cost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toJson()).toList(),
      };

  Costs copyWith({
    String? service,
    String? description,
    List<Cost>? cost,
  }) {
    return Costs(
      service: service ?? this.service,
      description: description ?? this.description,
      cost: cost ?? this.cost,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [service, description, cost];
}
