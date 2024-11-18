import 'package:flutter_test/flutter_test.dart';
import 'package:threads_api/api/models/profile_info.dart';

void main() {
  group('ProfileInfo.fromJson', () {
    test('should return a valid ProfileInfo object when JSON is complete', () {
      final json = {
        'id': '123',
        'username': 'testuser',
        'name': 'Test User',
        'threads_profile_picture_url': 'http://example.com/pic.jpg',
        'threads_biography': 'This is a bio',
      };

      final profileInfo = ProfileInfo.fromJson(json);

      expect(profileInfo.id, '123');
      expect(profileInfo.username, 'testuser');
      expect(profileInfo.name, 'Test User');
      expect(profileInfo.threadsProfilePictureUrl, 'http://example.com/pic.jpg');
      expect(profileInfo.threadsBiography, 'This is a bio');
    });

    test('should handle missing fields by using default values', () {
      final json = {
        'id': '123',
        'username': 'testuser',
      };

      final profileInfo = ProfileInfo.fromJson(json);

      expect(profileInfo.id, '123');
      expect(profileInfo.username, 'testuser');
      expect(profileInfo.name, '');
      expect(profileInfo.threadsProfilePictureUrl, '');
      expect(profileInfo.threadsBiography, '');
    });

    test('should handle null fields by using default values', () {
      final json = {
        'id': null,
        'username': null,
        'name': null,
        'threads_profile_picture_url': null,
        'threads_biography': null,
      };

      final profileInfo = ProfileInfo.fromJson(json);

      expect(profileInfo.id, '');
      expect(profileInfo.username, '');
      expect(profileInfo.name, '');
      expect(profileInfo.threadsProfilePictureUrl, '');
      expect(profileInfo.threadsBiography, '');
    });
  });
}