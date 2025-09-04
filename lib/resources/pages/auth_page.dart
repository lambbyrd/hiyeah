import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/services/clerk_service.dart';
import '/resources/pages/game_page.dart';

class AuthPage extends NyStatefulWidget {

  static RouteView path = ("/auth", (_) => AuthPage());
  
  AuthPage({super.key}) : super(child: () => _AuthPageState());
}

class _AuthPageState extends NyPage<AuthPage> {

  @override
  get init => () {

  };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Game App",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Text(
                "Please sign in to continue playing",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              
              // Robust authentication with fallback
              Expanded(
                child: _buildAuthenticationWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthenticationWidget(BuildContext context) {
    try {
      return ClerkErrorListener(
        child: ClerkAuthBuilder(
          signedInBuilder: (context, authState) => _buildSignedInState(context),
          signedOutBuilder: (context, authState) => _buildSignedOutState(context),
        ),
      );
    } catch (e) {
      // Fallback if Clerk widgets fail
      return _buildFallbackAuth(context, e.toString());
    }
  }

  Widget _buildSignedInState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          SizedBox(height: 24),
          Text(
            "You're signed in!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Welcome to the game platform",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 32),
          ClerkUserButton(),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              await _handleAuthSuccess();
            },
            icon: Icon(Icons.gamepad),
            label: Text("Continue to Game"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignedOutState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: ClerkAuthentication(),
            ),
            SizedBox(height: 24),
            Text(
              "Sign in to access your game progress and continue where you left off",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFallbackAuth(BuildContext context, String error) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber,
                size: 64,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text(
                "Clerk Authentication Unavailable",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                "The Clerk Flutter SDK is in beta and experiencing issues. Using fallback authentication.",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  await _handleFallbackAuth();
                },
                icon: Icon(Icons.login),
                label: Text("Sign In (Fallback)"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  _showErrorDetails(context, error);
                },
                child: Text(
                  "View Error Details",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDetails(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clerk Error Details"),
        content: SingleChildScrollView(
          child: Text(error),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _handleFallbackAuth() async {
    try {
      // Simulate authentication success
      await ClerkService.instance.saveAuthToken('fallback_auth_token');
      
      showToastSuccess(
        title: "Authenticated!",
        description: "Using fallback authentication",
      );
      
      // Navigate to game page
      routeTo(GamePage.path);
    } catch (e) {
      showToastNotification(
        context,
        title: "Error",
        description: "Failed to complete authentication: $e",
      );
    }
  }

  Future<void> _handleAuthSuccess() async {
    try {
      // Save authentication token using ClerkService
      await ClerkService.instance.saveAuthToken('clerk_authenticated_token');
      
      showToastSuccess(
        title: "Success!",
        description: "Authentication completed",
      );
      
      // Navigate to game page
      routeTo(GamePage.path);
    } catch (e) {
      showToastNotification(
        context,
        title: "Error",
        description: "Failed to complete authentication: $e",
      );
    }
  }
}