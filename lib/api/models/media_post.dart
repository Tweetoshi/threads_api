import 'package:threads_api/api/models/media_type.dart';

class MediaPost {
  final String id;
  final String mediaProductType;
  final MediaType mediaType;
  final String? mediaUrl;
  final String permalink;
  final Map<String, dynamic> owner;
  final String username;
  final String? text;
  final String timestamp;
  final String shortcode;
  final String? thumbnailUrl;
  final Map<String, dynamic>? children;
  final bool isQuotePost;
  final bool? hasReplies;
  final String? rootPost;
  final String? repliedTo;
  final bool? isReply;
  final bool? isReplyOwnedByMe;
  final String? replyAudience;

  MediaPost({
    required this.id,
    required this.mediaProductType,
    required this.mediaType,
    this.mediaUrl,
    required this.permalink,
    required this.owner,
    required this.username,
    this.text,
    required this.timestamp,
    required this.shortcode,
    this.thumbnailUrl,
    this.children,
    required this.isQuotePost,
    this.hasReplies,
    this.rootPost,
    this.repliedTo,
    this.isReply,
    this.isReplyOwnedByMe,
    this.replyAudience,
  });

  // Factory constructor to create a MediaPost object from JSON
  factory MediaPost.fromJson(Map<String, dynamic> json) {
    return MediaPost(
      id: json['id'] ?? '',
      mediaProductType: json['media_product_type'] ?? 'THREADS',
      mediaType: mediaTypeFromString(json['media_type']),
      mediaUrl: json['media_url'],
      permalink: json['permalink'] ?? '',
      owner: json['owner'] ?? {},
      username: json['username'] ?? 'unknown',
      text: json['text'],
      timestamp: json['timestamp'] ?? '',
      shortcode: json['shortcode'] ?? '',
      thumbnailUrl: json['thumbnail_url'],
      children: json['children'],
      isQuotePost: json['is_quote_post'] ?? false,
      hasReplies: json['has_replies'],
      rootPost: json['root_post']?['id'],
      repliedTo: json['replied_to']?['id'],
      isReply: json['is_reply'],
      isReplyOwnedByMe: json['is_reply_owned_by_me'],
      replyAudience: json['reply_audience'],
    );
  }

  // Method to convert a MediaPost object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'media_product_type': mediaProductType,
      'media_type': mediaType.receiveName,
      'media_url': mediaUrl,
      'permalink': permalink,
      'owner': owner,
      'username': username,
      'text': text,
      'timestamp': timestamp,
      'shortcode': shortcode,
      'thumbnail_url': thumbnailUrl,
      'children': children,
      'is_quote_post': isQuotePost,
      'has_replies': hasReplies,
      'root_post': rootPost,
      'replied_to': repliedTo,
      'is_reply': isReply,
      'is_reply_owned_by_me': isReplyOwnedByMe,
      'reply_audience': replyAudience,
    };
  }
}
