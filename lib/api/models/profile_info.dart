class ProfileInfo {
  final String id;
  final String username;
  final String name;
  final String threadsProfilePictureUrl;
  final String threadsBiography;

  ProfileInfo({
    required this.id,
    required this.username,
    required this.name,
    required this.threadsProfilePictureUrl,
    required this.threadsBiography,
  });

  // Factory constructor to create a ProfileInfo object from JSON
  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      threadsProfilePictureUrl: json['threads_profile_picture_url'] ?? '',
      threadsBiography: json['threads_biography'] ?? '',
    );
  }

  // Method to convert a ProfileInfo object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'threads_profile_picture_url': threadsProfilePictureUrl,
      'threads_biography': threadsBiography,
    };
  }
}
