import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

/// Builds Dio [FormData] payloads for image uploads.
class FileUploadHelper {
  /// Returns the [MediaType] for the image file at [path], based on its
  /// extension. Falls back to `image/jpeg` for unknown extensions.
  static MediaType getImageContentType(String path) {
    final extension = path.split('.').last.toLowerCase();

    return switch (extension) {
      'png' => MediaType('image', 'png'),
      'jpg' || 'jpeg' => MediaType('image', 'jpeg'),
      _ => MediaType('image', 'jpeg'),
    };
  }

  /// Wraps a single picked [image] in a `multipart/form-data` payload
  /// under the `file` field.
  static Future<FormData> createImageFormData(XFile image) async {
    final contentType = getImageContentType(image.path);

    return FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image.path,
        filename: image.name,
        contentType: contentType,
      ),
    });
  }

  /// Wraps a list of picked [images] in a `multipart/form-data` payload,
  /// each entry sent under the `file` field.
  static Future<FormData> createMultipleImagesFormData(
    List<XFile> images,
  ) async {
    final multipartFiles = await Future.wait(
      images.map((image) {
        final contentType = getImageContentType(image.path);

        return MultipartFile.fromFile(
          image.path,
          filename: image.name,
          contentType: contentType,
        );
      }),
    );

    return FormData.fromMap({'file': multipartFiles});
  }
}
