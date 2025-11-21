class Venue {
  final String name;
  final String? description;
  final String? imageUrl;
  final String? building;
  final String? floor;
  final List<String>? courses;

  const Venue({
    required this.name,
    this.description,
    this.imageUrl,
    this.building,
    this.floor,
    this.courses,
  });

  Venue copyWith({
    String? name,
    String? description,
    String? imageUrl,
    String? building,
    String? floor,
  }) {
    return Venue(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      courses: courses ?? courses
    );
  }
}
