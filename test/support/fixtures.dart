import 'dart:convert';
import 'dart:io';

/// Shared JSON-fixture loader for tests — the single replacement for the
/// per-file `_rawJson` / `_getJsonFromFile` helpers that used to be copied
/// into every test.
///
/// Two homes for fixtures:
/// - **Feature-local** — `test/features/<feature>/assets/<file>`, via
///   [fixtureMap] / [fixtureList] (pass the owning feature).
/// - **Shared across features** — `test/support/assets/<file>`, via
///   [sharedFixtureMap] / [sharedFixtureList] (no feature; these are domain
///   fixtures like `cart.json` / `restaurant.json` used by several features).
///
/// File contents are cached to skip repeat disk reads, but every call
/// **re-decodes**, so each caller gets a fresh, deeply-independent object that
/// is safe to mutate.
///
/// ```dart
/// final user = User.fromJson(fixtureMap('profile', 'user.json')); // feature-local
/// final cart = Cart.fromJson(sharedFixtureMap('cart.json'));      // shared
/// ```
final Map<String, String> _fileCache = <String, String>{};

String _readPath(String path) =>
    _fileCache[path] ??= File(path).readAsStringSync();

dynamic _decode(String path) => jsonDecode(_readPath(path));

// --- Feature-local fixtures: test/features/<feature>/assets/<file> ---

/// A feature-local JSON fixture decoded as-is. Prefer [fixtureMap] /
/// [fixtureList] for a typed result.
dynamic fixtureJson(String feature, String file) =>
    _decode('test/features/$feature/assets/$file');

/// A feature-local JSON-object fixture as `Map<String, dynamic>`.
Map<String, dynamic> fixtureMap(String feature, String file) =>
    fixtureJson(feature, file) as Map<String, dynamic>;

/// A feature-local JSON-array fixture as `List<dynamic>`.
List<dynamic> fixtureList(String feature, String file) =>
    fixtureJson(feature, file) as List<dynamic>;

// --- Shared fixtures: test/support/assets/<file> ---

/// A shared JSON fixture decoded as-is. Prefer [sharedFixtureMap] /
/// [sharedFixtureList] for a typed result.
dynamic sharedFixtureJson(String file) => _decode('test/support/assets/$file');

/// A shared JSON-object fixture as `Map<String, dynamic>`.
Map<String, dynamic> sharedFixtureMap(String file) =>
    sharedFixtureJson(file) as Map<String, dynamic>;

/// A shared JSON-array fixture as `List<dynamic>`.
List<dynamic> sharedFixtureList(String file) =>
    sharedFixtureJson(file) as List<dynamic>;
