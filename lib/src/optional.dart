import 'package:meta/meta.dart';

class Optional<T> {
  const Optional(this._value);

  const Optional.none() : this(null);

  bool get hasValue => iif(some: (_) => true, none: () => false);

  T valueOr(T Function() fallback) => iif(
        some: (value) => value,
        none: fallback,
      );

  U iif<U>({@required U Function(T) some, @required U Function() none}) {
    assert(some != null);
    assert(none != null);
    return _value != null ? some(_value) : none();
  }

  Optional<U> map<U>(U Function(T) f) => iif(
        some: (value) => Optional(f(value)),
        none: () => const Optional.none(),
      );

  Optional<U> flatMap<U>(Optional<U> Function(T) f) => iif(
        some: (value) => f(value),
        none: () => const Optional.none(),
      );

  Optional<U> map2<T1, U>(
    Optional<T1> other,
    U Function(T, T1) f,
  ) =>
      flatMap(
        (value) => other.map(
          (value1) => f(value, value1),
        ),
      );

  Optional<U> flatMap2<T1, U>(
    Optional<T1> other,
    Optional<U> Function(T, T1) f,
  ) =>
      flatMap(
        (value) => other.flatMap(
          (value1) => f(value, value1),
        ),
      );

  Optional<U> map3<T1, T2, U>(
    Optional<T1> other,
    Optional<T2> other2,
    U Function(T, T1, T2) f,
  ) =>
      flatMap(
        (value) => other.flatMap(
          (value1) => other2.map(
            (value2) => f(value, value1, value2),
          ),
        ),
      );

  Optional<U> flatMap3<T1, T2, U>(
    Optional<T1> other,
    Optional<T2> other2,
    Optional<U> Function(T, T1, T2) f,
  ) =>
      flatMap(
        (value) => other.flatMap(
          (value1) => other2.flatMap(
            (value2) => f(value, value1, value2),
          ),
        ),
      );

  @override
  String toString() => '$Optional($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Optional && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  final T _value;
}
