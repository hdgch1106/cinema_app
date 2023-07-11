import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/config/helpers/human_formats.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) widget.loadNextPage!();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.42,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Imagen
          _PosterImage(movie: movie),
          SizedBox(height: size.height * 0.005),
          //Title
          _MovieTitle(size: size, movie: movie, textStyle: textStyle),
          //Rating
          _MovieRating(size: size, movie: movie, textStyle: textStyle)
        ],
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({
    super.key,
    required this.size,
    required this.movie,
    required this.textStyle,
  });

  final Size size;
  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.38,
      child: Row(children: [
        Icon(
          Icons.star_half_outlined,
          color: Colors.yellow.shade800,
        ),
        SizedBox(width: size.height * 0.005),
        Text("${movie.voteAverage}",
            style:
                textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
        const Spacer(),
        Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall)
        //Text("${  movie.popularity}", style: textStyle.bodySmall)
      ]),
    );
  }
}

class _MovieTitle extends StatelessWidget {
  const _MovieTitle({
    super.key,
    required this.size,
    required this.movie,
    required this.textStyle,
  });

  final Size size;
  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.38,
      child: Text(
        movie.title,
        maxLines: 2,
        style: textStyle.titleSmall,
      ),
    );
  }
}

class _PosterImage extends StatelessWidget {
  const _PosterImage({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.38,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.posterPath,
          height: size.height * 0.26,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
                width: size.width * 0.38,
                height: size.height * 0.26,
                child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2)));
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return SizedBox(
                  width: size.width * 0.38,
                  height: size.height * 0.26,
                  child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2)));
            }
            return GestureDetector(
                onTap: () => context.push("/movie/${movie.id}"),
                child: FadeIn(child: child));
          },
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
