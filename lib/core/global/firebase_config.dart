/// Template toggle for the Firebase-backed examples (messaging, remote
/// config). Also gates Crashlytics: `main.dart` wires crash reporting
/// automatically once this is enabled, no separate toggle needed. Disabled by
/// default: the template never initializes Firebase and always registers
/// mock implementations.
///
/// To enable: run `flutterfire configure`, call `Firebase.initializeApp` in
/// `main()`, and flip [enabled].
class FirebaseConfig {
  static const bool enabled = false;
}
