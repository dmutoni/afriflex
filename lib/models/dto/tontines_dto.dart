// {
//   "name": "",
//   "contributionAmount": "",
//   "frequency": "",
//   "numberOfMembers": "",
//   "purpose": ""
// }

class CreateTontineDto {
  final String name;
  final int contributionAmount;
  final String frequency;
  final int numberOfMembers;
  final String purpose;

  CreateTontineDto({
    required this.name,
    required this.contributionAmount,
    required this.frequency,
    required this.numberOfMembers,
    required this.purpose,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contributionAmount': contributionAmount,
      'frequency': frequency,
      'numberOfMembers': numberOfMembers,
      'purpose': purpose,
    };
  }

  factory CreateTontineDto.fromJson(Map<String, dynamic> json) {
    return CreateTontineDto(
      name: json['name'] as String,
      contributionAmount: json['contributionAmount'] as int,
      frequency: json['frequency'] as String,
      numberOfMembers: json['numberOfMembers'] as int,
      purpose: json['purpose'] as String,
    );
  }
}