/// Represents configuration information about the publishing quota.
class PublishingQuotaConfig {
  /// The total number of allowed publishing operations in the quota period.
  final int quotaTotal;
  
  /// The duration of the quota period in seconds (typically 86400 seconds = 24 hours).
  final int quotaDuration;

  const PublishingQuotaConfig({
    required this.quotaTotal,
    required this.quotaDuration,
  });

  /// Creates a [PublishingQuotaConfig] from JSON data.
  factory PublishingQuotaConfig.fromJson(Map<String, dynamic> json) {
    return PublishingQuotaConfig(
      quotaTotal: json['quota_total'] as int,
      quotaDuration: json['quota_duration'] as int,
    );
  }

  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'quota_total': quotaTotal,
      'quota_duration': quotaDuration,
    };
  }
}

/// Represents the publishing quota information for a Threads user.
///
/// This class models the response from checking a user's publishing quota limit,
/// including their current usage and the quota configuration.
class PublishingQuota {
  /// The current quota usage (number of publishing operations performed in the current period).
  final int quotaUsage;
  
  /// Configuration information about the quota, including total limit and duration.
  final PublishingQuotaConfig config;

  const PublishingQuota({
    required this.quotaUsage,
    required this.config,
  });

  /// Creates a [PublishingQuota] from JSON data.
  factory PublishingQuota.fromJson(Map<String, dynamic> json) {
    return PublishingQuota(
      quotaUsage: json['quota_usage'] as int,
      config: PublishingQuotaConfig.fromJson(json['config'] as Map<String, dynamic>),
    );
  }

  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'quota_usage': quotaUsage,
      'config': config.toJson(),
    };
  }
} 