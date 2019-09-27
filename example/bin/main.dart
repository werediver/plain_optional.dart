import 'package:plain_optional/plain_optional.dart';

void main(List<String> arguments) {
  const x = Optional(1);
  const y = Optional<int>.none();
  final result = x.map((value) => value + y.valueOr(() => 0));
  print(result.valueOr(() => 0));
}
