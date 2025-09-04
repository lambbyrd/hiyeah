import 'package:flutter_test/flutter_test.dart';

// Import only working unit tests that don't require Nylo framework initialization
import 'unit/models/user_test.dart' as user_tests;
import 'unit/commands/current_time_command_test.dart' as command_tests;
import 'unit/services/clerk_service_simple_test.dart' as service_tests;
import 'widget_test.dart' as basic_tests;

void main() {
  group('Stable Unit Tests', () {
    user_tests.main();
    command_tests.main();
    service_tests.main();
    basic_tests.main();
  });
}