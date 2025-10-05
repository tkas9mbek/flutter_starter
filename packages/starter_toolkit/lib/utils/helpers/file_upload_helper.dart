import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadHelper {
  static MediaType getImageContentType(String path) {
    final extension = path.split('.').last.toLowerCase();

    return switch (extension) {
      'png' => MediaType('image', 'png'),
      'jpg' || 'jpeg' => MediaType('image', 'jpeg'),
      _ => MediaType('image', 'jpeg')
    };
  }

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

    return FormData.fromMap({
      'file': multipartFiles,
    });
  }
}
