import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('CurrentTimeCommand Logic Tests', () {
    test('should format time correctly with default format', () {
      final now = DateTime(2024, 1, 15, 14, 30, 45);
      const format = 'HH:mm:ss';
      final dateFormat = DateFormat(format);
      final formattedTime = dateFormat.format(now);

      expect(formattedTime, equals('14:30:45'));
    });

    test('should format time correctly with custom format', () {
      final now = DateTime(2024, 1, 15, 14, 30, 45);
      const format = 'yyyy-MM-dd HH:mm:ss';
      final dateFormat = DateFormat(format);
      final formattedTime = dateFormat.format(now);

      expect(formattedTime, equals('2024-01-15 14:30:45'));
    });

    test('should format time correctly with 12-hour format', () {
      final now = DateTime(2024, 1, 15, 14, 30, 45);
      const format = 'hh:mm:ss a';
      final dateFormat = DateFormat(format);
      final formattedTime = dateFormat.format(now);

      expect(formattedTime, equals('02:30:45 PM'));
    });

    test('should handle different date formats', () {
      final now = DateTime(2024, 3, 5, 9, 15, 30);
      
      expect(DateFormat('HH:mm').format(now), equals('09:15'));
      expect(DateFormat('dd/MM/yyyy').format(now), equals('05/03/2024'));
      expect(DateFormat('EEEE, MMMM d, y').format(now), equals('Tuesday, March 5, 2024'));
    });

    test('should handle edge case times', () {
      final midnight = DateTime(2024, 1, 1, 0, 0, 0);
      final noon = DateTime(2024, 1, 1, 12, 0, 0);
      final endOfDay = DateTime(2024, 1, 1, 23, 59, 59);

      expect(DateFormat('HH:mm:ss').format(midnight), equals('00:00:00'));
      expect(DateFormat('HH:mm:ss').format(noon), equals('12:00:00'));
      expect(DateFormat('HH:mm:ss').format(endOfDay), equals('23:59:59'));
    });

    test('should format time with milliseconds', () {
      final now = DateTime(2024, 1, 15, 14, 30, 45, 123);
      const format = 'HH:mm:ss.SSS';
      final dateFormat = DateFormat(format);
      final formattedTime = dateFormat.format(now);

      expect(formattedTime, equals('14:30:45.123'));
    });

    test('should handle various locale-specific formats', () {
      final now = DateTime(2024, 12, 25, 15, 30, 45);
      
      expect(DateFormat('MMM d, y').format(now), equals('Dec 25, 2024'));
      expect(DateFormat('d MMM yyyy').format(now), equals('25 Dec 2024'));
    });
  });
}