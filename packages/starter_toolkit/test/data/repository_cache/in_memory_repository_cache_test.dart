import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/repository_cache/in_memory_repository_cache.dart';

void main() {
  late InMemoryRepositoryCache cache;

  setUp(() {
    cache = InMemoryRepositoryCache();
  });

  test('miss runs fetch and returns its value', () async {
    var callCount = 0;

    final result = await cache.getOrFetch(
      () async {
        callCount++;

        return 'value';
      },
      key: 'key',
    );

    expect(result, 'value');
    expect(callCount, 1);
  });

  test('second call within TTL returns cached value without re-fetching',
      () async {
    var callCount = 0;

    Future<String> fetch() async {
      callCount++;

      return 'value';
    }

    final first = await cache.getOrFetch(fetch, key: 'key');
    final second = await cache.getOrFetch(fetch, key: 'key');

    expect(first, 'value');
    expect(second, 'value');
    expect(callCount, 1);
  });

  test('expired entry refetches', () async {
    var callCount = 0;

    Future<String> fetch() async {
      callCount++;

      return 'value-$callCount';
    }

    final first = await cache.getOrFetch(
      fetch,
      key: 'key',
      ttl: const Duration(milliseconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));
    final second = await cache.getOrFetch(
      fetch,
      key: 'key',
      ttl: const Duration(milliseconds: 5),
    );

    expect(first, 'value-1');
    expect(second, 'value-2');
    expect(callCount, 2);
  });

  test('per-call ttl overrides defaultTtl', () async {
    cache = InMemoryRepositoryCache(defaultTtl: const Duration(hours: 1));
    var callCount = 0;

    Future<String> fetch() async {
      callCount++;

      return 'value';
    }

    await cache.getOrFetch(
      fetch,
      key: 'key',
      ttl: const Duration(milliseconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await cache.getOrFetch(
      fetch,
      key: 'key',
      ttl: const Duration(milliseconds: 5),
    );

    expect(callCount, 2);
  });

  test('invalidate(key) forces refetch for that key only', () async {
    var aCount = 0;
    var bCount = 0;

    Future<String> fetchA() async {
      aCount++;

      return 'a';
    }

    Future<String> fetchB() async {
      bCount++;

      return 'b';
    }

    await cache.getOrFetch(fetchA, key: 'a');
    await cache.getOrFetch(fetchB, key: 'b');

    cache.invalidate('a');

    await cache.getOrFetch(fetchA, key: 'a');
    await cache.getOrFetch(fetchB, key: 'b');

    expect(aCount, 2);
    expect(bCount, 1);
  });

  test('invalidate() clears all entries', () async {
    var aCount = 0;
    var bCount = 0;

    Future<String> fetchA() async {
      aCount++;

      return 'a';
    }

    Future<String> fetchB() async {
      bCount++;

      return 'b';
    }

    await cache.getOrFetch(fetchA, key: 'a');
    await cache.getOrFetch(fetchB, key: 'b');

    cache.invalidate();

    await cache.getOrFetch(fetchA, key: 'a');
    await cache.getOrFetch(fetchB, key: 'b');

    expect(aCount, 2);
    expect(bCount, 2);
  });

  test('a throwing fetch propagates the error and caches nothing', () async {
    var callCount = 0;

    Future<String> throwingFetch() async {
      callCount++;

      throw StateError('boom');
    }

    await expectLater(
      () => cache.getOrFetch(throwingFetch, key: 'key'),
      throwsA(isA<StateError>()),
    );

    Future<String> succeedingFetch() async {
      callCount++;

      return 'value';
    }

    final result = await cache.getOrFetch(succeedingFetch, key: 'key');

    expect(result, 'value');
    expect(callCount, 2);
  });
}
