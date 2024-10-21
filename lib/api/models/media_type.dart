enum MediaType { textPost, image, video, carouselAlbum, audio, repost }

extension MediaTypeExtension on MediaType {
  String get receiveName {
    switch (this) {
      case MediaType.textPost:
        return 'TEXT_POST';
      case MediaType.image:
        return 'IMAGE';
      case MediaType.video:
        return 'VIDEO';
      case MediaType.carouselAlbum:
        return 'CAROUSEL_ALBUM';
      case MediaType.audio:
        return 'AUDIO';
      case MediaType.repost:
        return 'REPOST_FACADE';
    }
  }

  String get postName {
    switch (this) {
      case MediaType.textPost:
        return 'TEXT';
      case MediaType.image:
        return 'IMAGE';
      case MediaType.video:
        return 'VIDEO';
      case MediaType.carouselAlbum:
        return 'CAROUSEL';
      case MediaType.audio:
        return 'AUDIO';
      case MediaType.repost:
        return 'REPOST_FACADE';
    }
  }
}

MediaType mediaTypeFromString(String type) {
  switch (type) {
    case 'TEXT_POST':
      return MediaType.textPost;
    case 'IMAGE':
      return MediaType.image;
    case 'VIDEO':
      return MediaType.video;
    case 'CAROUSEL_ALBUM':
      return MediaType.carouselAlbum;
    case 'AUDIO':
      return MediaType.audio;
    case 'REPOST_FACADE':
      return MediaType.repost;
    default:
      return MediaType.textPost;
  }
}
