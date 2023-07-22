import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => context.push("/home/0/movie/${movie.id}"),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
              height: size.height * 0.22,
              fit: BoxFit.cover,
              placeholder: const AssetImage("assets/loaders/bottle_loader.gif"),
              image: NetworkImage(movie.posterPath))),
    );
  }
}
