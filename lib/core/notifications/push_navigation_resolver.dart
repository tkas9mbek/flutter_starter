import 'package:starter/core/notifications/model/push_message.dart';

/// Decouples "a push was tapped" from routing.
///
/// The UI layer (which owns the router) assigns [onOpened]; data-layer
/// callbacks that can't reach the widget tree — e.g. a local-notification
/// tap handled outside the widget tree — call [resolve].
class PushNavigationResolver {
  void Function(PushMessage message)? onOpened;

  void resolve(PushMessage message) => onOpened?.call(message);
}
