import 'package:plain_optional/src/optional.dart';
import 'package:test/test.dart';

void main() {
  group('$Optional', () {
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
