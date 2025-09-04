
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('basic test to ensure test framework works', () {
    expect(2 + 2, equals(4));
  });
  
  test('string manipulation test', () {
    const String testString = 'Flutter App';
    expect(testString.toLowerCase(), equals('flutter app'));
    expect(testString.length, equals(11));
  });
  
  test('list operations test', () {
    final List<int> numbers = [1, 2, 3, 4, 5];
    expect(numbers.length, equals(5));
    expect(numbers.contains(3), isTrue);
    expect(numbers.last, equals(5));
  });
}
