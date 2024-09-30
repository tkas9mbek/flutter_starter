import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

part 'deep_link_bloc.freezed.dart';

@freezed
class DeepLinkEvent with _$DeepLinkEvent {
  const factory DeepLinkEvent.received(Uri link) = _InitedDeepLinkEvent;
}

@freezed
class DeepLinkState with _$DeepLinkState {
  const factory DeepLinkState.initial() = _InitialDeepLinkState;
}

@injectable
class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  StreamSubscription? deeplinkSub;

  @override
  Future<void> close() async {
    deeplinkSub?.cancel();
    super.close();
  }

  DeepLinkBloc() : super(const DeepLinkState.initial()) {
    deeplinkSub = linkStream.listen(
      (link) {
        if (link == null) {
          return;
        }

        final uri = Uri.parse(link);

        add(DeepLinkEvent.received(uri));
      },
    );

    on<DeepLinkEvent>(
      (event, emit) {
        event.when(
          received: (link) async {
            // TODO(you): Implement deep link handling
          },
        );
      },
    );
  }
}
