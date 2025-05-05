import 'package:threads_api/api/base_service.dart';
import 'package:threads_api/api/models/fields.dart';
import 'package:threads_api/api/models/media_insights.dart';
import 'package:threads_api/api/models/media_post.dart';
import 'package:threads_api/api/models/media_type.dart';
import 'package:threads_api/api/models/threads_response.dart';
import 'package:threads_api/api/models/media_container_status.dart';
import 'package:threads_api/api/models/publishing_quota.dart';

abstract class ThreadsMediaService {
  factory ThreadsMediaService({required String accessToken}) =>
      _ThreadsMediaService(accessToken: accessToken);

  /// Retrieves a list of media posts (threads) created by a user.
  ///
  /// This method fetches the threads for a given user based on their `userId`.
  /// Optionally, you can pass a list of fields to specify which data should be
  /// included in the response.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user whose threads
  ///   are being requested.
  /// - `fields` (optional): A list of `MediaFields` that defines specific
  ///   fields to be included in the response. If no fields are specified,
  ///   the API will return a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a list of `MediaPost` objects, representing
  ///   the threads posted by the user.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while parsing the response.
  ///
  /// ## API Reference:
  /// - [Get User Threads](https://developers.facebook.com/docs/threads/threads-media#get-user-threads)
  ///
  /// Example usage:
  /// ```dart
  /// final threads = await threadsMediaService.getUserThreads(
  ///   userId: '1234567890',
  ///   fields: [MediaFields.id, MediaFields.mediaType, MediaFields.text],
  /// );
  /// ```
  Future<ThreadsResponse<List<MediaPost>>> getUserThreads({
    required String userId,
    List<MediaFields>? fields,
    int? limit,
  });

  /// Retrieves a single media post (thread) by its unique post ID.
  ///
  /// This method fetches a specific thread using its `postId`. Optionally,
  /// you can pass a list of fields to specify which data should be included
  /// in the response.
  ///
  /// ## Parameters:
  /// - `postId` (required): The unique identifier of the thread (post)
  ///   being requested.
  /// - `fields` (optional): A list of `MediaFields` to define specific
  ///   fields that should be included in the response. If no fields are
  ///   specified, the API will return a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `MediaPost` object, representing the
  ///   details of the requested thread.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while parsing the response.
  ///
  /// ## API Reference:
  /// - [Retrieve a Single Thread's Media Object](https://developers.facebook.com/docs/threads/threads-media#retrieve-a-single-threads-media-object)
  ///
  /// Example usage:
  /// ```dart
  /// final thread = await threadsMediaService.getThreadById(
  ///   postId: '9876543210',
  ///   fields: [MediaFields.id, MediaFields.mediaType],
  /// );
  /// ```
  Future<MediaPost> getThreadById({
    required String postId,
    List<MediaFields>? fields,
  });

  /// Creates a container for a new media post (thread) on behalf of a user.
  ///
  /// This method is the first step in creating a post on Threads. It generates
  /// a container that holds the content of the post, such as text, media (e.g.,
  /// images or videos), and other related data. You can optionally reply to
  /// another thread or quote a post.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user for whom the
  ///   thread container is being created.
  /// - `text` (optional): The textual content of the thread.
  /// - `imageUrl` (optional): The URL of the image to include in the thread.
  ///   This field is required if the post includes media content.
  /// - `inReplyToId` (optional): The ID of the thread that this post is replying to.
  /// - `quotePostId` (optional): The ID of the post being quoted.
  /// - `mediaType` (required): The type of media included in the post (e.g.,
  ///   text, image, video). Defaults to `MediaType.textPost`.
  /// - `isCarouselItem` (optional): Indicates whether the post is part of a
  ///   carousel item (multiple images/videos in a single post).
  /// - `children` (optional): A list of child media container IDs if the container is part of
  ///   a carousel of posts.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `String`, representing the ID of the
  ///   created container.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Create a Container for a Post](https://developers.facebook.com/docs/threads/posts#create-container)
  /// - [Quote a Post](https://developers.facebook.com/docs/threads/posts/quote-posts)
  /// - [Reply to Post](https://developers.facebook.com/docs/threads/reply-management#respond-to-replies)
  ///
  /// Example usage:
  /// ```dart
  /// final containerId = await threadsMediaService.createThreadContainer(
  ///   userId: '1234567890',
  ///   text: 'This is a new post!',
  ///   mediaType: MediaType.textPost,
  /// );
  /// ```

  Future<String> createThreadContainer({
    required String userId,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? inReplyToId,
    String? quotePostId,
    MediaType mediaType,
    bool isCarouselItem,
    List<String>? children,
  });

  /// Publishes a media post (thread) using a previously created container.
  ///
  /// This method is the second step in creating a post on Threads. After a
  /// container is created using the `createThreadContainer` method, you use
  /// this function to publish the post. The `mediaContainerId` is required to
  /// finalize and publish the post.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user who is publishing
  ///   the thread.
  /// - `mediaContainerId` (required): The ID of the container created in the
  ///   previous step (`createThreadContainer`), which holds the post's content.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `String`, representing the ID of the
  ///   published post (thread).
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Publish a Post](https://developers.facebook.com/docs/threads/posts#publish-post)
  ///
  /// Example usage:
  /// ```dart
  /// final threadId = await threadsMediaService.postThread(
  ///   userId: '1234567890',
  ///   mediaContainerId: 'container12345',
  /// );
  /// ```
  Future<String> postThread({
    required String userId,
    required String mediaContainerId,
  });

  /// Reposts an existing media post (thread) by its unique post ID.
  ///
  /// This method allows you to repost an existing thread (post) on behalf of a
  /// user. The `postId` is required to identify the thread that will be reposted.
  ///
  /// ## Parameters:
  /// - `postId` (required): The unique identifier of the thread (post)
  ///   that you want to repost.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a `String`, representing the ID of the reposted
  ///   thread.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Repost a Thread](https://developers.facebook.com/docs/threads/posts/reposts)
  ///
  /// Example usage:
  /// ```dart
  /// final repostId = await threadsMediaService.repostThread(
  ///   postId: '9876543210',
  /// );
  /// ```
  Future<String> repostThread({
    required String postId,
  });

  /// Retrieves a list of replies to a specific thread (post) by its unique post ID.
  ///
  /// This method fetches a paginated list of all top-level replies. Optionally, you can
  /// specify a list of fields to customize the data included in the response.
  ///
  /// ## Parameters:
  /// - `postId` (required): The unique identifier of the thread (post)
  ///   whose replies are being requested.
  /// - `fields` (optional): A list of `MediaFields` to define specific
  ///   fields to include in the response. If no fields are specified, the
  ///   API returns a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a list of `MediaPost` objects representing
  ///   the replies to the thread.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Get Replies to a Thread](https://developers.facebook.com/docs/threads/reply-management#get-replies)
  ///
  /// Example usage:
  /// ```dart
  /// final replies = await threadsMediaService.getReplies(
  ///   postId: '1234567890',
  ///   fields: [MediaFields.id, MediaFields.mediaType],
  /// );
  /// ```
  Future<ThreadsResponse<List<MediaPost>>> getReplies({
    required String postId,
    List<MediaFields>? fields,
    int? limit,
  });

  /// Retrieves a conversation thread for a specific post by its unique post ID.
  ///
  /// This method fetches a paginated and flattened list of all top-level and nested replies.
  /// Optionally, you can pass a list of fields to customize
  /// the data included in the response.
  ///
  /// ## Parameters:
  /// - `postId` (required): The unique identifier of the thread (post)
  ///   for which the conversation is being requested.
  /// - `fields` (optional): A list of `MediaFields` to define specific
  ///   fields to include in the response. If no fields are specified, the
  ///   API returns a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a list of `MediaPost` objects representing
  ///   the conversation (including replies and other related posts).
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Get Conversations for a Thread](https://developers.facebook.com/docs/threads/reply-management#get-conversations)
  ///
  /// Example usage:
  /// ```dart
  /// final conversation = await threadsMediaService.getConversations(
  ///   postId: '1234567890',
  ///   fields: [MediaFields.id, MediaFields.mediaType],
  /// );
  /// ```
  Future<ThreadsResponse<List<MediaPost>>> getConversations({
    required String postId,
    List<MediaFields>? fields,
    int? limit,
  });

  // Retrieves a list of all replies made by a specific user by their unique user ID.
  ///
  /// This method fetches all replies created by a user on Threads. Optionally,
  /// you can specify which fields to include in the response by passing a list
  /// of `MediaFields`.
  ///
  /// ## Parameters:
  /// - `userId` (required): The unique identifier of the user whose replies
  ///   are being requested.
  /// - `fields` (optional): A list of `MediaFields` to define specific fields
  ///   to include in the response. If no fields are specified, the API returns
  ///   a default set of fields.
  ///
  /// ## Returns:
  /// - A `Future` that resolves to a list of `MediaPost` objects representing
  ///   the replies made by the user.
  ///
  /// ## Errors:
  /// - Throws an `Exception` if the API request fails or if an error occurs
  ///   while processing the response.
  ///
  /// ## API Reference:
  /// - [Retrieve a List of All a User's Replies](https://developers.facebook.com/docs/threads/reply-management#retrieve-a-list-of-all-a-user-s-replies)
  ///
  /// Example usage:
  /// ```dart
  /// final replies = await threadsMediaService.getUserReplies(
  ///   userId: '1234567890',
  ///   fields: [MediaFields.id, MediaFields.message],
  /// );
  /// ```
  Future<ThreadsResponse<List<MediaPost>>> getUserReplies({
    required String userId,
    List<MediaFields>? fields,
    int? limit,
  });

  /// Retrieves media insights for a post by its ID.
  ///
  /// Fetches metrics like views, likes, replies, reposts, and quotes. You can
  /// specify which metrics to retrieve using the `fields` parameter. If no fields
  /// are provided, default metrics are fetched.
  ///
  /// Parameters:
  /// - `postId` (required): The unique identifier of the post.
  /// - `fields` (optional): A list of `MediaInsightFields` to specify which metrics to fetch.
  ///
  /// Returns:
  /// - A `Future` that resolves to a list of `MediaInsight` objects.
  ///
  /// Throws:
  /// - An `Exception` if the API request fails.

  Future<List<MediaInsight>> getMediaInsights({
    required String postId,
    List<MediaInsightFields>? fields,
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
  /// final containerStatus = await threadsMediaService.getMediaContainerStatus(
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
  /// final quotaInfo = await threadsMediaService.getPublishingQuota(
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

class _ThreadsMediaService extends BaseService implements ThreadsMediaService {
  _ThreadsMediaService({required super.accessToken});

  @override
  Future<ThreadsResponse<List<MediaPost>>> getUserThreads({
    required String userId,
    List<MediaFields>? fields,
    int? limit,
  }) async {
    try {
      final response = await super.get(
          'https://graph.threads.net/v1.0/$userId/threads',
          queryParameters: {
            'fields': getFieldsParam(fields),
            'limit': limit,
          });

      return ThreadsResponse<List<MediaPost>>(
          beforeCursor: response.data['paging']?['cursors']?['before'],
          afterCursor: response.data['paging']?['cursors']?['after'],
          data: response.data['data']
              .map<MediaPost>((reply) => MediaPost.fromJson(reply))
              .toList());
    } catch (e) {
      throw Exception('Failed to get user Threads $e');
    }
  }

  @override
  Future<MediaPost> getThreadById({
    required String postId,
    List<MediaFields>? fields,
  }) async {
    try {
      final response = await super
          .get('https://graph.threads.net/v1.0/$postId', queryParameters: {
        'fields': getFieldsParam(fields),
      });

      final data = MediaPost.fromJson(response.data);

      return data;
    } catch (e) {
      throw Exception('Failed to get Thread post $e');
    }
  }

  @override
  Future<String> createThreadContainer(
      {required String userId,
      String? text,
      String? imageUrl,
      String? videoUrl,
      String? inReplyToId,
      MediaType mediaType = MediaType.textPost,
      String? quotePostId,
      bool? isCarouselItem,
      List<String>? children}) async {
    assert(text != null || imageUrl != null);
    try {
      final response = await super.post(
          'https://graph.threads.net/v1.0/$userId/threads',
          queryParameters: {
            'media_type': mediaType.postName,
            'text': text,
            'image_url': imageUrl,
            'video_url': videoUrl,
            'quote_post_id': quotePostId,
            'reply_to_id': inReplyToId,
            'is_carousel_item': isCarouselItem,
            'children': children?.join(',')
          });

      return response.data['id'];
    } catch (e) {
      throw Exception('Failed to post container $e');
    }
  }

  @override
  Future<String> postThread({
    required String userId,
    required String mediaContainerId,
  }) async {
    try {
      final response = await super.post(
          'https://graph.threads.net/v1.0/$userId/threads_publish',
          queryParameters: {
            'creation_id': mediaContainerId,
          });

      return response.data['id'];
    } catch (e) {
      throw Exception('Failed to post Thread $e');
    }
  }

  @override
  Future<String> repostThread({
    required String postId,
  }) async {
    try {
      final response = await super.post(
        'https://graph.threads.net/v1.0/$postId/repost',
      );

      return response.data['id'];
    } catch (e) {
      throw Exception('Failed to post Thread $e');
    }
  }

  @override
  Future<ThreadsResponse<List<MediaPost>>> getReplies({
    required String postId,
    List<MediaFields>? fields,
    int? limit,
  }) async {
    try {
      final response = await super.get(
        'https://graph.threads.net/v1.0/$postId/replies',
        queryParameters: {
          'fields': getFieldsParam(fields),
          'limit': limit,
        },
      );
      return ThreadsResponse<List<MediaPost>>(
          beforeCursor: response.data['paging']?['cursors']?['before'],
          afterCursor: response.data['paging']?['cursors']?['after'],
          data: response.data['data']
              .map<MediaPost>((reply) => MediaPost.fromJson(reply))
              .toList());
    } catch (e) {
      throw Exception('Failed to fetch replies $e');
    }
  }

  @override
  Future<ThreadsResponse<List<MediaPost>>> getConversations({
    required String postId,
    List<MediaFields>? fields,
    int? limit,
  }) async {
    try {
      final response = await super.get(
        'https://graph.threads.net/v1.0/$postId/conversation',
        queryParameters: {
          'fields': getFieldsParam(fields),
        },
      );

      return ThreadsResponse<List<MediaPost>>(
          beforeCursor: response.data['paging']?['cursors']?['before'],
          afterCursor: response.data['paging']?['cursors']?['after'],
          data: response.data['data']
              .map<MediaPost>((reply) => MediaPost.fromJson(reply))
              .toList());
    } catch (e) {
      throw Exception('Failed to fetch conversations $e');
    }
  }

  @override
  Future<ThreadsResponse<List<MediaPost>>> getUserReplies({
    required String userId,
    List<MediaFields>? fields,
    int? limit,
  }) async {
    try {
      final response = await super.get(
        'https://graph.threads.net/v1.0/$userId/replies',
        queryParameters: {
          'fields': getFieldsParam(fields),
        },
      );

      return ThreadsResponse<List<MediaPost>>(
          beforeCursor: response.data['paging']?['cursors']?['before'],
          afterCursor: response.data['paging']?['cursors']?['after'],
          data: response.data['data']
              .map<MediaPost>((reply) => MediaPost.fromJson(reply))
              .toList());
    } catch (e) {
      throw Exception('Failed to retrieve user replies');
    }
  }

  @override
  Future<List<MediaInsight>> getMediaInsights({
    required String postId,
    List<MediaInsightFields>? fields,
  }) async {
    try {
      final response = await super.get(
          'https://graph.threads.net/v1.0/$postId/insights',
          queryParameters: {
            'metric': getMediaInsightFieldsParam(fields),
          });

      final insights = response.data['data'] as List<dynamic>;

      return insights
          .map<MediaInsight>((insight) => MediaInsight.fromJson(insight))
          .toList();
    } catch (e) {
      throw Exception('Failed to get media insights $e');
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
