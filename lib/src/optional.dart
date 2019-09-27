import 'package:meta/meta.dart';

class Optional<T> {
  const Optional(this._value);

  const Optional.none() : this(null);

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

  final T _value;
}
