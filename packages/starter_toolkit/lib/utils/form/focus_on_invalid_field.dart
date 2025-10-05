import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void focusOnInvalidStateField(GlobalKey<FormBuilderState> formKey) {
  final entry = formKey.currentState?.fields.entries
      .firstWhereOrNull((element) => element.value.hasError);

  if (entry != null) {
    final field = entry.value;
    final context = field.context;
    final renderObject = context.findRenderObject();

    if (renderObject is RenderBox) {
      final scroll = Scrollable.maybeOf(context)?.position;

      if (scroll != null) {
        final position = renderObject.localToGlobal(Offset.zero);

        scroll.moveTo(
          scroll.pixels + position.dy - 150,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
