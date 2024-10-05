import 'package:flutter_test/flutter_test.dart';
import 'package:todos/src/l10n/lk.dart';
import 'package:todos/src/utils/common/text_validators.dart';

void main() {
  group('TextValidators', () {
    test('clearSpaces', () {
      expect(clearSpaces(''), '');
      expect(clearSpaces('      '), '');
      expect(clearSpaces('  r a w T e x t  '), 'rawText');
      expect(clearSpaces('rawText'), 'rawText');
    });

    test('validateNotEmpty', () {
      expect(validateNotEmpty('   '), Lk.require);
      expect(validateNotEmpty(' d  '), null);
    });

    test('validateEmail', () {
      expect(validateEmail('   '), Lk.require);
      expect(validateEmail(' d  '), Lk.errorInvalidEmail);
      expect(validateEmail('email@gmailcom'), Lk.errorInvalidEmail);
      expect(validateEmail('emailgmail.com'), Lk.errorInvalidEmail);
      expect(validateEmail('email@gmail.com'), null);
    });
  });
}
