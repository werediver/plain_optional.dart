import 'package:plain_optional/src/optional.dart';
import 'package:test/test.dart';

void main() {
  group('$Optional', () {
    group("valueOr", () {
      test("returns the value", () {
        expect(const Optional(1).valueOr(() => throw Exception()), 1);
      });

      test("falls back", () {
        expect(const Optional<int>.none().valueOr(() => 1), 1);
      });
    });

    group("map", () {
      test("transforms a value", () {
        expect(const Optional(1).map((value) => "$value"), const Optional("1"));
      });

      test("preserves none", () {
        expect(
          const Optional<int>.none().map((value) => "$value"),
          const Optional<String>.none(),
        );
      });
    });

    group("flatMap", () {
      test("transforms a value to a value", () {
        expect(
          const Optional(1).flatMap((value) => Optional("$value")),
          const Optional("1"),
        );
      });

      test("transforms a value to none", () {
        expect(
          const Optional(1).flatMap((value) => const Optional<String>.none()),
          const Optional<String>.none(),
        );
      });

      test("preserves none", () {
        expect(
          const Optional<int>.none().flatMap((value) => Optional("$value")),
          const Optional<String>.none(),
        );
      });
    });

    group("map2", () {
      test("transforms two values", () {
        expect(
          const Optional(1).map2(const Optional(2), (int a, int b) => a + b),
          const Optional(3),
        );
      });
    });

    group("flatMap2", () {
      test("transforms two values", () {
        expect(
          const Optional(1)
              .flatMap2(const Optional(2), (int a, int b) => Optional(a + b)),
          const Optional(3),
        );
      });
    });

    group("map3", () {
      test("transforms three values", () {
        expect(
          const Optional(1).map3(
            const Optional(2),
            const Optional(3),
            (int a, int b, int c) => a + b + c,
          ),
          const Optional(6),
        );
      });
    });

    group("flatMap3", () {
      test("transforms three values", () {
        expect(
          const Optional(1).flatMap3(
            const Optional(2),
            const Optional(3),
            (int a, int b, int c) => Optional(a + b + c),
          ),
          const Optional(6),
        );
      });
    });

    group("equality test", () {
      test("matches empty instances", () {
        expect(const Optional<int>.none(), const Optional(null));
      });

      test("does not match empty and non-empty instances", () {
        expect(const Optional(1), isNot(const Optional<int>.none()));
      });

      test("matches equal non-empty instances", () {
        expect(const Optional(1), const Optional(1));
      });

      test("does not match distinct non-empty instances", () {
        expect(const Optional(1), isNot(const Optional(2)));
      });
    });

    test("provides informative description", () {
      const value = "abc";
      final description = const Optional(value).toString();

      expect(description, contains("$Optional"));
      expect(description, contains("$value"));
    });
  });
}
