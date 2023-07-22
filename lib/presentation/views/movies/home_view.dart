import 'package:flutter/material.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(moviesLoadingProvider);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProviders);
    final popularMovies = ref.watch(popularMoviesProviders);
    final topratedMovies = ref.watch(topRatedMoviesProviders);
    final upcomingMovies = ref.watch(upcomingMoviesProviders);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //const CustomAppbar(),
            MoviesSlideshow(movies: moviesSlideshow),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: "En cines",
              subTitle: "Ahora",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProviders.notifier).loadNextPage();
              },
            ),
            /* MovieHorizontalListview(
              movies: popularMovies,
              title: "Populares",
              subTitle: "En este mes",
              loadNextPage: () {
                ref.read(popularMoviesProviders.notifier).loadNextPage();
              },
            ), */
            MovieHorizontalListview(
              movies: topratedMovies,
              title: "Mejor calificadas",
              subTitle: "Desde siempre",
              loadNextPage: () {
                ref.read(topRatedMoviesProviders.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: "Proximamente",
              subTitle: "Solo en cines",
              loadNextPage: () {
                ref.read(upcomingMoviesProviders.notifier).loadNextPage();
              },
            )
          ],
        );
      }, childCount: 1))
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
