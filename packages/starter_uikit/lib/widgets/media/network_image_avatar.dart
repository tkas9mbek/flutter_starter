import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

final _colors = [
  AppColors.brightAmber,
  AppColors.vibrantGreen,
  AppColors.vividPurple,
];

/// Circular avatar that loads [imageUrl] with caching, showing a spinner
/// while loading. On error it falls back to [placeholder], or to the first
/// letter of [name] over a color derived from the URL.
class NetworkImageAvatar extends StatelessWidget {
  const NetworkImageAvatar({
    required this.imageUrl,
    required this.size,
    this.name,
    this.placeholder,
    super.key,
  });

  final String imageUrl;
  final double size;
  final String? name;
  final ImageProvider? placeholder;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final randomColor = _colors[imageUrl.hashCode % _colors.length];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: randomColor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const CustomCircularProgressIndicator.adaptive(
                color: AppColors.pureWhite,
              ),
          errorWidget: (context, url, error) => placeholder != null
              ? Image(image: placeholder!, fit: BoxFit.cover)
              : Center(
                  child: Text(
                    name?.isEmpty ?? true ? '-' : name![0].toUpperCase(),
                    style: textStyles.boldTitle18.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
