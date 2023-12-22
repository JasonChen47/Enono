import 'dart:io';

class Project {
  final String title;
  final String date;
  final String description;
  final List<dynamic> skills;
  String? imageURL;

  Project({
    required this.title,
    required this.date,
    required this.description,
    required this.skills,
    this.imageURL,
  });
}
