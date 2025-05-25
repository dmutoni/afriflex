class Role {
  final String id;
  final String description;
  final bool adminLevel;
  final String name;
  final String status;
  final String authority;

  Role({
    required this.id,
    required this.description,
    required this.adminLevel,
    required this.name,
    required this.status,
    required this.authority,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      description: json['description'] as String,
      adminLevel: json['adminLevel'] as bool,
      name: json['name'] as String,
      status: json['status'] as String,
      authority: json['authority'] as String,
    );
  }
}