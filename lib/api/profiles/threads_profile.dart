import 'package:threads_api/api/base_service.dart';
import 'package:threads_api/api/models/fields.dart';
import 'package:threads_api/api/models/profile_info.dart';
import 'package:threads_api/api/models/profile_insights.dart';
import 'package:threads_api/api/models/media_container_status.dart';
import 'package:threads_api/api/models/publishing_quota.dart';

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
  
  /// Checks the status of a media container.
  ///
  /// This method retrieves the current status of a media container that was created
  /// for publishing content on Threads. It's particularly useful when the publishing
  /// process does not immediately return a media ID and you need to check the
  /// container's status.
  ///
  /// The status can be one of the following:
  /// - `EXPIRED` — The container was not published within 24 hours and has expired.
  /// - `ERROR` — The container failed to complete the publishing process.
  /// - `FINISHED` — The container and its media object are ready to be published.
  /// - `IN_PROGRESS` — The container is still in the publishing process.
  /// - `PUBLISHED` — The container's media object has been published.
  ///
  /// In case of an error, the method will also return an error message, which can be
  /// one of the following:
  /// - `FAILED_DOWNLOADING_VIDEO`
  /// - `FAILED_PROCESSING_AUDIO`
  /// - `FAILED_PROCESSING_VIDEO`
  /// - `INVALID_ASPEC_RATIO`
  /// - `INVALID_BIT_RATE`
  /// - `INVALID_DURATION`
  /// - `INVALID_FRAME_RATE`
  /// - `INVALID_AUDIO_CHANNELS`
  /// - `INVALID_AUDIO_CHANNEL_LAYOUT`
  /// - `UNKNOWN`
  ///
  /// ## Parameters:
  /// - `containerId` (required): The unique identifier of the media container
  ///   whose status is being checked.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `MediaContainerStatus` object, containing
  ///   the status and any error message.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Threads API Troubleshooting](https://developers.facebook.com/docs/threads/troubleshooting#publishing-does-not-return-a-media-id)
  ///
  /// Example usage:
  /// ```dart
  /// final containerStatus = await threadsProfileService.getMediaContainerStatus(
  ///   containerId: '17889615691921648',
  /// );
  /// 
  /// if (containerStatus.status == 'FINISHED') {
  ///   // Proceed with publishing
  /// } else if (containerStatus.status == 'ERROR') {
  ///   print('Error: ${containerStatus.errorMessage}');
  /// }
  /// ```
  Future<MediaContainerStatus> getMediaContainerStatus({
    required String containerId,
  });
  
  /// Retrieves the publishing quota limit for a specific user by their unique user ID.
  ///
  /// This method allows you to check a user's current API usage total and quota limits
  /// to validate that they have not exhausted their publishing API quota.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user whose publishing quota
  ///   is being requested.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `PublishingQuota` object, containing information
  ///   about the user's current quota usage and the quota configuration.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Threads API Troubleshooting](https://developers.facebook.com/docs/threads/troubleshooting#retrieve-publishing-quota-limit)
  ///
  /// Example usage:
  /// ```dart
  /// final quotaInfo = await threadsProfileService.getPublishingQuota(
  ///   userId: '1234567890',
  /// );
  /// 
  /// if (quotaInfo.quotaUsage < quotaInfo.config.quotaTotal) {
  ///   // User has not exceeded their quota, proceed with publishing
  /// }
  /// ```
  Future<PublishingQuota> getPublishingQuota({
    required String userId,
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
  
  @override
  Future<MediaContainerStatus> getMediaContainerStatus({
    required String containerId,
  }) async {
    try {
      final response = await super.get(
        'https://graph.threads.net/v1.0/$containerId',
        queryParameters: {
          'fields': 'status,error_message',
        },
      );
      
      return MediaContainerStatus.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get media container status: $e');
    }
  }
  
  @override
  Future<PublishingQuota> getPublishingQuota({
    required String userId,
  }) async {
    try {
      final response = await super.get(
        'https://graph.threads.net/v1.0/$userId/threads_publishing_limit',
        queryParameters: {
          'fields': 'quota_usage,config',
        },
      );
      
      final dataList = response.data['data'] as List<dynamic>;
      
      if (dataList.isEmpty) {
        throw Exception('No publishing quota data returned');
      }
      
      return PublishingQuota.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get publishing quota: $e');
    }
  }
}
