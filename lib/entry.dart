import 'dart:io';

class Entry {
  final String date;
  final String text;
  final String title;
  File? imageFile;

  Entry({
    required this.date,
    required this.text,
    required this.title,
    this.imageFile,
  });
}
