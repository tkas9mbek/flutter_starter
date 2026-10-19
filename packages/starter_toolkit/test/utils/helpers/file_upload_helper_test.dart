import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/helpers/file_upload_helper.dart';

void main() =>
    test('content type follows the extension and defaults to JPEG', () {
      final cases = {
        '/tmp/photo.png': 'image/png',
        '/tmp/PHOTO.PNG': 'image/png',
        '/tmp/photo.jpg': 'image/jpeg',
        '/tmp/photo.jpeg': 'image/jpeg',
        '/tmp/photo.heic': 'image/jpeg',
      };

      for (final MapEntry(key: path, value: mimeType) in cases.entries) {
        expect(FileUploadHelper.getImageContentType(path).mimeType, mimeType);
      }
    });
