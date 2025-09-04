import 'package:nylo_framework/nylo_framework.dart';

/* Clerk Service
|--------------------------------------------------------------------------
| Service wrapper for Clerk authentication integration with Nylo framework
| This service bridges Clerk authentication with Nylo's Auth system
|-------------------------------------------------------------------------- */

class ClerkService {
  static ClerkService? _instance;
  static ClerkService get instance => _instance ??= ClerkService._();
  
  ClerkService._();

  /// Check if user is authenticated via Clerk state
  Future<bool> isAuthenticated() async {
    try {
      // Use NyStorage directly instead of Keys to avoid decoder issues
      String? authStatus = await NyStorage.read('auth_status');
      return authStatus == 'authenticated';
    } catch (e) {
      NyLogger.debug('ClerkService isAuthenticated error: $e');
      return false;
    }
  }

  /// Save authentication token to Nylo storage
  Future<void> saveAuthToken(String token) async {
    try {
      // Use NyStorage directly to avoid decoder issues
      await NyStorage.save('auth_token', token);
      await NyStorage.save('auth_status', 'authenticated');
      NyLogger.debug('ClerkService: Auth token saved successfully');
    } catch (e) {
      NyLogger.debug('ClerkService saveAuthToken error: $e');
    }
  }

  /// Clear authentication token from Nylo storage
  Future<void> clearAuthToken() async {
    try {
      // Use NyStorage directly to avoid decoder issues
      await NyStorage.delete('auth_token');
      await NyStorage.delete('auth_status');
      NyLogger.debug('ClerkService: Auth token cleared successfully');
    } catch (e) {
      NyLogger.debug('ClerkService clearAuthToken error: $e');
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    await clearAuthToken();
  }
}