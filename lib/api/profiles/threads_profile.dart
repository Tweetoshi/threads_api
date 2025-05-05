import 'package:threads_api/api/base_service.dart';
import 'package:threads_api/api/models/fields.dart';
import 'package:threads_api/api/models/profile_info.dart';
import 'package:threads_api/api/models/profile_insights.dart';

abstract class ThreadsProfileService {
  factory ThreadsProfileService({required String accessToken}) =>
      _ThreadsProfileService(accessToken: accessToken);

  /// Retrieves profile information for a specific user by their unique user ID.
  ///
  /// This method fetches the profile information of a user on Threads. You can
  /// specify which profile fields to retrieve by passing a list of `ProfileFields`.
  /// If no fields are specified, the API will return a default set of profile
  /// details.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user whose profile is
  ///   being requested.
  /// - `fields` (optional): A list of `ProfileFields` to specify which specific
  ///   profile fields to include in the response. If no fields are provided,
  ///   the API returns a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `ProfileInfo` object representing the
  ///   user's profile information, such as their name, username, bio, and
  ///   other details.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Get User Profile](https://developers.facebook.com/docs/threads/threads-profiles)
  ///
  /// Example usage:
  /// ```dart
  /// final profile = await threadsMediaService.getUserProfile(
  ///   userId: '1234567890',
  ///   fields: [ProfileFields.id, ProfileFields.username, ProfileFields.bio],
  /// );
  /// ```
  Future<ProfileInfo> getUserProfile({
    required String userId,
    List<ProfileFields>? fields,
  });

  /// Retrieves profile insights for a specific user by their unique user ID.
  ///
  /// This method fetches various engagement metrics for a user's profile,
  /// including views, likes, replies, reposts, quotes, and follower-related insights.
  /// You can optionally specify which insight fields to retrieve by providing
  /// a list of `ProfileInsightFields`. If no fields are specified, the API will
  /// return all available insights by default.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user whose profile insights
  ///   are being requested.
  /// - `fields` (optional): A list of `ProfileInsightFields` to specify which insights
  ///   to include in the response. If no fields are provided, the API will return
  ///   a default set of insights.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `ProfileInsights` object, representing
  ///   the requested metrics, including views, likes, replies, reposts, quotes,
  ///   followers count, and follower demographics.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Profile Insights API](https://developers.facebook.com/docs/threads/insights)
  ///
  /// Example usage:
  /// ```dart
  /// final insights = await threadsMediaService.getProfileInsights(
  ///   userId: '1234567890',
  ///   fields: [ProfileInsightFields.views, ProfileInsightFields.followersCount],
  /// );
  /// ```
  ///
  /// Example returned data:
  /// ```dart
  /// {
  ///   'views': 5000,
  ///   'followers_count': 1200,
  ///   'follower_demographics': {...}
  /// }
  /// ```
  Future<ProfileInsights> getProfileInsights({
    required String userId,
    List<ProfileInsightFields>? fields,
  });
}

class _ThreadsProfileService extends BaseService
    implements ThreadsProfileService {
  _ThreadsProfileService({required super.accessToken});

  @override
  Future<ProfileInfo> getUserProfile({
    required String userId,
    List<ProfileFields>? fields,
  }) async {
    try {
      final response = await super
          .get('https://graph.threads.net/v1.0/$userId', queryParameters: {
        'fields': getProfileFieldsParam(fields),
      });

      return ProfileInfo.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get user profile');
    }
  }

  @override
  Future<ProfileInsights> getProfileInsights({
    required String userId,
    List<ProfileInsightFields>? fields,
  }) async {
    try {
      // Call the API with the selected fields
      final response = await super.get(
        'https://graph.threads.net/v1.0/$userId/threads_insights',
        queryParameters: {
          'metric': getUserInsightFieldsParam(fields),
        },
      );

      final insights = response.data['data'] as List<dynamic>;

      // Convert the insights to a structured ProfileInsights object
      final Map<String, dynamic> insightsMap = {};

      for (var insight in insights) {
        final String name = insight['name'];
        final dynamic value = insight['total_value']['value'];
        insightsMap[name] = value;
      }

      return ProfileInsights.fromJson(insightsMap);
    } catch (e) {
      throw Exception('Failed to get user profile insights: $e');
    }
  }
}
