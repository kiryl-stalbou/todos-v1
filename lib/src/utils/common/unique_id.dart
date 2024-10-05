import 'dart:math';

const _range = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

String generateUniqueId() {
  final random = Random();

  final millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;

  // Web max int 2^32
  final seed = random.nextInt(millisecondsSinceEpoch & 0xffffffff);

  return String.fromCharCodes(
    Iterable.generate(
      20,
      (_) => _range.codeUnitAt(random.nextInt(seed) % _range.length),
    ),
  );
}
