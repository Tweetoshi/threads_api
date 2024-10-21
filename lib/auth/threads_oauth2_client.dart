import 'package:dio/dio.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:threads_api/auth/long_live_token_response.dart';
import 'package:threads_api/auth/scopes.dart';

/// This class is responsible for handling OAuth 2.0 authentication
/// for the Threads API, including short-lived and long-lived token exchanges.
class ThreadsOAuthClient {
  final Dio _dio = Dio(); // HTTP client to send requests to the Threads API.

  // OAuth 2.0 credentials (client_id, client_secret, redirect_uri)
  final String clientId;
  final String clientSecret;
  final String redirectUri;

  /// Constructor to initialize the ThreadsOAuthClient with
  /// required credentials.
  ThreadsOAuthClient({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
  });

  /// Step 1: Build the authorization URL that the user should visit
  /// to grant access to their Threads account.
  ///
  /// - `scopes`: A list of OAuth 2.0 scopes specifying the permissions the
  ///   app is requesting (e.g., `['read', 'write']`).
  ///
  /// Returns the URL to initiate the authorization process.
  String getAuthorizationUrl(List<Scope> scopes) {
    // Build query parameters for OAuth 2.0 authorization
    final queryParams = {
      'response_type': 'code', // Requesting an authorization code
      'client_id': clientId, // The client ID of the application
      'redirect_uri': redirectUri, // The URI to redirect after login
      'scope':
          scopes.map((scope) => scope.value).join(','), // Join scopes by space
      'state': '1', // A CSRF protection mechanism, static for now
    };

    // Construct the full authorization URL using HTTPS
    final uri = Uri.https('threads.net', '/oauth/authorize', queryParams);

    return uri.toString(); // Return the full authorization URL as a string
  }

  /// Step 2: Handle user authentication by opening a browser window
  /// and allowing the user to log in and authorize the app.
  ///
  /// - `callbackUrlScheme`: The custom URL scheme used to redirect back
  ///   after the user authorizes the app.
  /// - `scopes`: The OAuth 2.0 scopes (permissions) requested.
  ///
  /// Returns the access token if the authorization succeeds.
  Future<String> authenticate({
    required String callbackUrlScheme,
    required List<Scope> scopes,
    bool? preferEphemeral = false,
  }) async {
    // Get the authorization URL for the user to visit
    final authUrl = getAuthorizationUrl(scopes);

    // Open the authorization page in a browser and listen for redirect
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl.toString(),
      options: FlutterWebAuth2Options(
        intentFlags: ephemeralIntentFlags,
        preferEphemeral: preferEphemeral,
      ),
      callbackUrlScheme: callbackUrlScheme,
    );

    // Extract the authorization code from the redirect URI
    final code = Uri.parse(result).queryParameters['code'];

    // If the code is not null, exchange it for an access token
    if (code != null) {
      return await exchangeCodeForShortLiveToken(
          code); // Exchange code for token
    } else {
      throw Exception('Authorization failed'); // Error if code is missing
    }
  }

  /// Step 3: Exchange the authorization code obtained in the previous step
  /// for a short-lived access token.
  ///
  /// - `authorizationCode`: The authorization code returned from the
  ///   user’s login and authorization.
  ///
  /// Returns a map containing the access token and other information.
  Future<String> exchangeCodeForShortLiveToken(String authorizationCode) async {
    // Make a POST request to exchange the authorization code for an access token
    final response = await _dio.post(
      'https://graph.threads.net/oauth/access_token',
      data: {
        'client_id': clientId, // The client ID of the app
        'client_secret': clientSecret, // The client secret of the app
        'grant_type': 'authorization_code', // OAuth 2.0 grant type
        'redirect_uri': redirectUri, // The redirect URI for the app
        'code':
            authorizationCode, // The authorization code received from the user
      },
    );

    // Check if the response was successful (HTTP 200)
    if (response.statusCode == 200) {
      return (response.data as Map<String, dynamic>)[
          'access_token']; // Return the access token and additional data
    } else {
      throw Exception(
          'Failed to exchange code for access token'); // Handle errors
    }
  }

  /// Step 4 (Optional): Refresh the access token when it expires.
  /// This is only needed if the access token has expired and a refresh token
  /// was provided.
  ///
  /// - `refreshToken`: The refresh token provided with the initial token response.
  ///
  /// Returns a new access token.
  Future<LongLivedTokenResponse> refreshAccessToken(String refreshToken) async {
    // Make a GET request to refresh the access token using the refresh token
    try {
      final response = await _dio.get(
        'https://graph.threads.net/refresh_access_token',
        queryParameters: {
          'grant_type':
              'th_refresh_token', // OAuth 2.0 grant type for refresh tokens
          'access_token': refreshToken, // The access token to use
        },
      );

      // Check if the response was successful (HTTP 200)
      if (response.statusCode == 200) {
        // Parse the response data into a LongLivedTokenResponse object
        return LongLivedTokenResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to refresh access token');
      }
    } catch (e) {
      throw Exception('Failed to refresh access token $e');
    }
  }

  /// Step 5: Exchange a short-lived access token for a long-lived one.
  ///
  /// - `shortLivedToken`: The short-lived access token obtained after the
  ///   user authorizes the app.
  ///
  /// Returns a map containing the long-lived access token and additional data.
  Future<LongLivedTokenResponse> exchangeForLongLivedToken(
      String shortLivedToken) async {
    // Make a GET request to exchange the short-lived token for a long-lived token
    final response = await _dio.get(
      'https://graph.threads.net/access_token',
      queryParameters: {
        'grant_type':
            'th_exchange_token', // Special grant type for long-lived tokens
        'client_secret': clientSecret, // The client secret of the app
        'access_token': shortLivedToken, // The short-lived access token
      },
    );

    // Check if the response was successful (HTTP 200)
    if (response.statusCode == 200) {
      // Parse the response data into a LongLivedTokenResponse object
      return LongLivedTokenResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to exchange token');
    }
  }
}
