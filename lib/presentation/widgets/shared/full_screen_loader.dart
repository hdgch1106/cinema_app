import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FullScreenLoader extends ConsumerStatefulWidget {
  const FullScreenLoader({super.key});

  @override
  FullScreenLoaderState createState() => FullScreenLoaderState();
}

class FullScreenLoaderState extends ConsumerState<FullScreenLoader> {
  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando películas",
      "Comprando palomitas de maíz",
      "Esto está tardando más de lo esperado"
    ];
    return Stream.periodic(const Duration(seconds: 2), (step) {
      return messages[step];
    }).take(messages.length);
  }

/*   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        ref.read(reloadButtonProvider.notifier).updateReloadButton();
      });
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Cargando...");
              return Text(snapshot.data!);
            },
          ),
          const SizedBox(height: 10),
          /* if (reloadButton)
            FadeIn(
              child: ElevatedButton.icon(
                  onPressed: () {
                    if (nowPlayingMovies.isEmpty) {
                      ref
                          .read(nowPlayingMoviesProviders.notifier)
                          .loadNextPage();
                      ref.read(popularMoviesProviders.notifier).loadNextPage();
                      ref.read(topRatedMoviesProviders.notifier).loadNextPage();
                      ref.read(upcomingMoviesProviders.notifier).loadNextPage();
                    }
                    if (nowPlayingMovies.isNotEmpty) {
                      ref.read(popularMoviesProviders.notifier).loadNextPage();
                      ref.read(topRatedMoviesProviders.notifier).loadNextPage();
                      ref.read(upcomingMoviesProviders.notifier).loadNextPage();
                    }
                  },
                  icon: const Icon(Icons.refresh_outlined),
                  label: const Text("Volver a cargar")),
            ), */
        ],
      ),
    );
  }
}
