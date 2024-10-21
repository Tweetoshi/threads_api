enum MediaFields {
  id,
  mediaProductType,
  mediaType,
  mediaUrl,
  permalink,
  owner,
  username,
  text,
  timestamp,
  shortcode,
  thumbnailUrl,
  children,
  isQuotePost,
  quotePostId,
  hasReplies,
  rootPost,
  repliedTo,
  isReply,
  isReplyOwnedByMe,
  hideStatus,
  replyAudience,
}

extension MediaFieldsExtension on MediaFields {
  String get name {
    switch (this) {
      case MediaFields.mediaProductType:
        return 'media_product_type';
      case MediaFields.mediaType:
        return 'media_type';
      case MediaFields.mediaUrl:
        return 'media_url';
      case MediaFields.permalink:
        return 'permalink';
      case MediaFields.owner:
        return 'owner';
      case MediaFields.username:
        return 'username';
      case MediaFields.text:
        return 'text';
      case MediaFields.timestamp:
        return 'timestamp';
      case MediaFields.shortcode:
        return 'shortcode';
      case MediaFields.thumbnailUrl:
        return 'thumbnail_url';
      case MediaFields.children:
        return 'children';
      case MediaFields.isQuotePost:
        return 'is_quote_post';
      case MediaFields.quotePostId:
        return 'quote_post_id';
      case MediaFields.hasReplies:
        return 'has_replies';
      case MediaFields.rootPost:
        return 'root_post';
      case MediaFields.repliedTo:
        return 'replied_to';
      case MediaFields.isReply:
        return 'is_reply';
      case MediaFields.isReplyOwnedByMe:
        return 'is_reply_owned_by_me';
      case MediaFields.hideStatus:
        return 'hide_status';
      case MediaFields.replyAudience:
        return 'reply_audience';
      default:
        return 'id';
    }
  }
}

String getFieldsParam(List<MediaFields>? fields) {
  return (fields ?? [MediaFields.id]).map((f) => f.name).join(',');
}

enum ProfileFields {
  id,
  username,
  name,
  profilePictureUrl,
  biography,
}

extension ProfileFieldsExtension on ProfileFields {
  String get name {
    switch (this) {
      case ProfileFields.username:
        return 'username';
      case ProfileFields.name:
        return 'name';
      case ProfileFields.profilePictureUrl:
        return 'threads_profile_picture_url';
      case ProfileFields.biography:
        return 'threads_biography';
      default:
        return 'id';
    }
  }
}

String getProfileFieldsParam(List<ProfileFields>? fields) {
  return (fields ?? [ProfileFields.id]).map((f) => f.name).join(',');
}

enum ProfileInsightFields {
  views,
  likes,
  replies,
  reposts,
  quotes,
  followersCount,
  followerDemographics,
}

extension ProfileInsightFieldsExtension on ProfileInsightFields {
  String get name {
    switch (this) {
      case ProfileInsightFields.views:
        return 'views';
      case ProfileInsightFields.likes:
        return 'likes';
      case ProfileInsightFields.replies:
        return 'replies';
      case ProfileInsightFields.reposts:
        return 'reposts';
      case ProfileInsightFields.quotes:
        return 'quotes';
      case ProfileInsightFields.followersCount:
        return 'followers_count';
      case ProfileInsightFields.followerDemographics:
        return 'follower_demographics';
      default:
        return '';
    }
  }
}

String getUserInsightFieldsParam(List<ProfileInsightFields>? fields) {
  return (fields ?? []).map((f) => f.name).join(',');
}

enum MediaInsightFields {
  views,
  likes,
  replies,
  reposts,
  quotes,
}

extension MediaInsightFieldsExtension on MediaInsightFields {
  String get name {
    switch (this) {
      case MediaInsightFields.views:
        return 'views';
      case MediaInsightFields.likes:
        return 'likes';
      case MediaInsightFields.replies:
        return 'replies';
      case MediaInsightFields.reposts:
        return 'reposts';
      case MediaInsightFields.quotes:
        return 'quotes';
      default:
        return '';
    }
  }
}

String getMediaInsightFieldsParam(List<MediaInsightFields>? fields) {
  return (fields ?? []).map((f) => f.name).join(',');
}
