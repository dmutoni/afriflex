import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/tontine_enum.dart';

class Tontine extends Serializable {
  String id;
  String name;
  ETontineFrequency frequency;

  Tontine({
    required this.id,
    required this.name,
    required this.frequency,
  });

  factory Tontine.fromJson(Map<String, dynamic> json) {
    return Tontine(
      id: json['id'] as String,
      name: json['name'] as String,
      frequency: ETontineFrequency.values.firstWhere(
        (e) => e.name == json['frequency'] as String,
        orElse: () => ETontineFrequency.weekly,
      ),
    );
  }
  
  @override
  Serializable fromJson(Map<String, dynamic> json) {
    return Tontine.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency.name,
    };
  }
}