import 'package:flutter/material.dart';
class Movie{
  int id;
  final String type;
  final String title;
  final String imageUrl;
  final String releaseDate;
  final  rateing;
  Movie(
      {
        required this.type,
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.releaseDate,
        required this.rateing
      });
}
