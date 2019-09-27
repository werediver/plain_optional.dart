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

  @override
  String toString() => '$Optional($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Optional && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  final T _value;
}
