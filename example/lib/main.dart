// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:flutter/material.dart';
import 'package:threads_api/api/threads_api.dart';
import 'package:threads_api/auth/scopes.dart';
import 'package:threads_api/auth/threads_oauth2_client.dart';

void main() {
  runApp(const MaterialApp(home: Example()));
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late ThreadsOAuthClient client;

  String? longLiveToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    client = ThreadsOAuthClient(
      clientId: '1234567889', // Replace with your app's client ID
      clientSecret:
          'xxxxxxxxxxxxxxxxxxxxxxxx', // Replace with your app's client secret
      redirectUri: 'com.example.oauth/redirect', // Your app's custom scheme
    );
  }

  void authenticateUser() async {
    final scopes = [
      Scope.threadsContentPublish,
      Scope.threadsBasic,
    ]; // Threads API scopes
    final shortLiveToken = await client.authenticate(
      callbackUrlScheme: 'com.example.oauth', // Your app's custom scheme
      scopes: scopes,
    );

    final token = await client.exchangeForLongLivedToken(shortLiveToken);
    setState(() {
      longLiveToken = token.accessToken;
    });
  }

  void getUserProfile() async {
    final threadsApi = ThreadsApi(longLiveToken!);
    final profile = await threadsApi.profile.getUserProfile(userId: 'me');

    print('User Profile: $profile');
  }

  void getUserThreads() async {
    final threadsApi = ThreadsApi(longLiveToken!);

    final threads = await threadsApi.media.getUserThreads(userId: 'me');

    print('User Threads: $threads');
  }

  void refreshUserToken() async {
    const refreshToken =
        'EXISTING_LONG_LIVED_TOKEN'; // Use the saved refresh token

    final newTokenResponse = await client.refreshAccessToken(refreshToken);

    print('New Access Token: ${newTokenResponse.accessToken}');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('Access Token: $_accessToken'),
              ElevatedButton(
                onPressed: () async {
                  authenticateUser();
                },
                child: const Text('Push!'),
              ),
              if (longLiveToken != null)
                ElevatedButton(
                  onPressed: () async {
                    getUserProfile();
                  },
                  child: const Text('Get profile data'),
                ),
              if (longLiveToken != null)
                ElevatedButton(
                  onPressed: () async {
                    getUserThreads();
                  },
                  child: const Text('Get user threads'),
                )
            ],
          ),
        ),
      );
}
