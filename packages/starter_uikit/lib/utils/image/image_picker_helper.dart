import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class ImagePickerHelper {
  static Future<XFile?> showPickImageDialog(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return showCupertinoModalPopup<XFile>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            UikitLocalizer.of(context).cancellation,
            style: TextStyle(
              color: theme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final image = await ImagePickerHelper.pickImage(
                source: ImageSource.camera,
              );
              navigator.pop(image);
            },
            child: Text(
              UikitLocalizer.of(context).camera,
              style: TextStyle(
                color: theme.textPrimary,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final image = await ImagePickerHelper.pickImage(
                source: ImageSource.gallery,
              );
              navigator.pop(image);
            },
            child: Text(
              UikitLocalizer.of(context).gallery,
              style: TextStyle(
                color: theme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<XFile?> pickImage({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    int imageQuality = 75,
    double? maxWidth = 480,
    double? maxHeight = 480,
    bool requestFullMetadata = true,
    bool onlyGalleryOnIosDebug = true,
  }) async {
    final realSource = kDebugMode && Platform.isIOS && onlyGalleryOnIosDebug
        ? ImageSource.gallery
        : source;

    final image = await ImagePicker().pickImage(
      source: realSource,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
      requestFullMetadata: requestFullMetadata,
    );

    if (image == null) {
      return null;
    }

    final path = image.path;
    final orientedImage = await compute(_fixOrientation, path);

    return XFile(orientedImage);
  }

  static Future<String> _fixOrientation(String path) async {
    final capturedImage = img.decodeImage(await File(path).readAsBytes());

    if (capturedImage == null) {
      return path;
    }

    final orientedImage = img.bakeOrientation(capturedImage);
    await File(path).writeAsBytes(img.encodeJpg(orientedImage));

    return path;
  }
}
