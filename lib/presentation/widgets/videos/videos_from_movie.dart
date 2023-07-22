import 'package:cinema_app/domain/entities/video.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);
});

class VideosFromMovie extends ConsumerWidget {
  final int movieId;
  const VideosFromMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));
    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, __) => const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      )),
      loading: () => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;
  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    if (videos.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Video",
            style: textStyle.headlineSmall,
          ),
        ),
        _YoutubeVideoPlayer(youtubeId: videos.first.youtubeKey),
      ],
    );
  }
}

class _YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  const _YoutubeVideoPlayer({required this.youtubeId});

  @override
  State<_YoutubeVideoPlayer> createState() => __YoutubeVideoPlayerState();
}

class __YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        flags: const YoutubePlayerFlags(
            hideThumbnail: true,
            showLiveFullscreenButton: false,
            mute: false,
            autoPlay: false,
            disableDragSeek: true,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [YoutubePlayer(controller: _controller)],
      ),
    );
  }
}
