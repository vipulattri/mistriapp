class Mistri {
  final String? id;
  final String name;
  final String skill;
  final String phone;
  final String location;
  final int experience;

  Mistri({
    this.id,
    required this.name,
    required this.skill,
    required this.phone,
    required this.location,
    required this.experience,
  });

  factory Mistri.fromJson(Map<String, dynamic> json) {
    return Mistri(
      id: json['_id'],
      name: json['name'],
      skill: json['skill'],
      phone: json['phone'],
      location: json['location'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'skill': skill,
      'phone': phone,
      'location': location,
      'experience': experience,
    };
  }
}
