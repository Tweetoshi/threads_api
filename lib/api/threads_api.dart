import 'package:threads_api/api/profiles/threads_profile.dart';
import 'package:threads_api/api/threads_media/threads_media.dart';

abstract class ThreadsApi {
  factory ThreadsApi(String accessToken) => _ThreadsApi(accessToken);

  ThreadsProfileService get profile;

  ThreadsMediaService get media;
}

class _ThreadsApi implements ThreadsApi {
  final String accessToken;

  _ThreadsApi(this.accessToken)
      : profile = ThreadsProfileService(accessToken: accessToken),
        media = ThreadsMediaService(accessToken: accessToken);

  @override
  final ThreadsProfileService profile;

  @override
  final ThreadsMediaService media;
}
