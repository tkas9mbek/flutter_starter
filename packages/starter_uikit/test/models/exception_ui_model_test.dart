import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/models/exception_ui_model.dart';

void main() => group('ExceptionUiModel', () {
  test('noRetry disables retry and reuses the description for snackbars', () {
    const model = ExceptionUiModel.noRetry(description: 'Bad', title: 'T');

    expect(
      model,
      const ExceptionUiModel(
        title: 'T',
        description: 'Bad',
        snackbarDescription: 'Bad',
        canRetry: false,
      ),
    );
  });

  test('simple has no title and retries by default', () {
    const model = ExceptionUiModel.simple(description: 'Bad');

    expect(model.title, isNull);
    expect(model.snackbarDescription, 'Bad');
    expect(model.canRetry, isTrue);
  });

  test('models with different fields are not equal', () {
    const base = ExceptionUiModel(description: 'a', snackbarDescription: 'a');

    expect(
      base,
      isNot(const ExceptionUiModel(description: 'a', snackbarDescription: 'b')),
    );
    expect(
      base,
      isNot(
        const ExceptionUiModel(
          description: 'a',
          snackbarDescription: 'a',
          canRetry: false,
        ),
      ),
    );
    expect(
      base,
      isNot(
        const ExceptionUiModel(
          description: 'a',
          snackbarDescription: 'a',
          title: 't',
        ),
      ),
    );
  });
});
