import '/resources/pages/auth_page.dart';
import '/app/services/clerk_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Auth Route Guard
|--------------------------------------------------------------------------
| Checks if the User is authenticated using Clerk authentication.
|
| * [Tip] Create new route guards using the CLI 🚀
| Run the below in the terminal to create a new route guard.
| "dart run nylo_framework:main make:route_guard check_subscription"
|
| Learn more https://nylo.dev/docs/6.x/router#route-guards
|-------------------------------------------------------------------------- */

class AuthRouteGuard extends NyRouteGuard {
  AuthRouteGuard();

  @override
  onRequest(PageRequest pageRequest) async {
    // Check if user is authenticated via Clerk
    bool isLoggedIn = await ClerkService.instance.isAuthenticated();
    
    // Debug logging
    NyLogger.debug('AuthRouteGuard: User authenticated = $isLoggedIn');
    NyLogger.debug('AuthRouteGuard: Checking access to protected route');
    
    if (!isLoggedIn) {
      NyLogger.debug('AuthRouteGuard: Redirecting to auth page');
      // Redirect to auth page instead of home page
      return redirect(AuthPage.path);
    }

    NyLogger.debug('AuthRouteGuard: Allowing access to protected route');
    return pageRequest;
  }
}
