import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/core/data/exceptions/unknown_exception.dart';
import 'package:flutter_starter/resources/resources.dart';
import 'package:flutter_starter/theme/app_colors.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/status/custom_circular_progress_indicator.dart';
import 'package:flutter_starter/uikit/status/failure_widget.dart';
import 'package:flutter_starter/utils/functions/format_hours_minutes_seconds.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  /// Video player with play/pause and delete buttons.
  const AppVideoPlayer({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;
  late final Future<void> chewieControllerFuture;
  bool showControls = true;
  double aspectRatio = 2;
  String timerText = '';

  @override
  void initState() {
    super.initState();

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    chewieControllerFuture = initVideoPlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer() async {
    await videoPlayerController.initialize();

    videoPlayerController.addListener(() {
      if (!mounted) {
        return;
      }

      final durationSeconds =
          videoPlayerController.value.position.inSeconds == 0
              ? videoPlayerController.value.duration.inSeconds
              : videoPlayerController.value.position.inSeconds;

      setState(
        () => timerText = formatHoursMinutesSeconds(durationSeconds),
      );

      if (videoPlayerController.value.isPlaying) {
        setState(() => showControls = false);
      } else {
        setState(() => showControls = true);
      }
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: aspectRatio,
      placeholder: const CustomCircularProgressIndicator(),
      showControls: false,
    );

    setState(() {
      aspectRatio = videoPlayerController.value.aspectRatio;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.black,
        ),
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder(
          future: chewieControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return FailureWidgetSmall(
                  textColor: AppColors.white,
                  exception: UnknownException(
                    snapshot.error!,
                    snapshot.stackTrace!,
                  ),
                );
              }

              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (videoPlayerController.value.isPlaying) {
                        videoPlayerController.pause();
                      } else {
                        videoPlayerController.play();
                      }
                    },
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Text(
                      timerText,
                      style: textStyles.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  if (showControls) ...[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: chewieController.play,
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.only(left: 5),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  SvgIcons.playArrow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            }

            return const CustomCircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
