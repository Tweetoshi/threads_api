class ProfileInsights {
  final int views;
  final int likes;
  final int replies;
  final int reposts;
  final int quotes;
  final int followersCount;
  final Map<String, dynamic>? followerDemographics;

  ProfileInsights({
    required this.views,
    required this.likes,
    required this.replies,
    required this.reposts,
    required this.quotes,
    required this.followersCount,
    this.followerDemographics,
  });

  factory ProfileInsights.fromJson(Map<String, dynamic> json) {
    return ProfileInsights(
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      replies: json['replies'] ?? 0,
      reposts: json['reposts'] ?? 0,
      quotes: json['quotes'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      followerDemographics: json['follower_demographics'], // demographics might be nested JSON
    );
  }
}
