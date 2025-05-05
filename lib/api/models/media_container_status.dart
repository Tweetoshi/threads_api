/// Represents the status of a media container in the Threads API.
///
/// This class models the response from checking a media container's status,
/// including the current state of the container (EXPIRED, ERROR, FINISHED,
/// IN_PROGRESS, or PUBLISHED) and any error message if applicable.
class MediaContainerStatus {
  /// The ID of the container
  final String id;
  
  /// The current status of the container.
  /// 
  /// Can be one of:
  /// - `EXPIRED` — The container was not published within 24 hours and has expired.
  /// - `ERROR` — The container failed to complete the publishing process.
  /// - `FINISHED` — The container and its media object are ready to be published.
  /// - `IN_PROGRESS` — The container is still in the publishing process.
  /// - `PUBLISHED` — The container's media object has been published.
  final String status;
  
  /// Error message in case the status is ERROR.
  ///
  /// Can be one of:
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
  final String? errorMessage;

  const MediaContainerStatus({
    required this.id,
    required this.status,
    this.errorMessage,
  });

  /// Creates a [MediaContainerStatus] from JSON data.
  factory MediaContainerStatus.fromJson(Map<String, dynamic> json) {
    return MediaContainerStatus(
      id: json['id'] as String,
      status: json['status'] as String,
      errorMessage: json['error_message'] as String?,
    );
  }

  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
    };
  }
} 