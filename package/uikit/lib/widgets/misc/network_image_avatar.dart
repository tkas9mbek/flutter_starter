import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/app_colors.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/status/custom_circular_progress_indicator.dart';

final _colors = [
  AppColors.brightAmber,
  AppColors.vibrantGreen,
  AppColors.vividPurple,
];

class NetworkImageAvatar extends StatelessWidget {
  /// Avatar with a network image.
  ///
  /// * If [placeholder] is null, the first letter of the [name] will be displayed,
  /// When the image is not loaded.
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: randomColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CustomCircularProgressIndicator(
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
