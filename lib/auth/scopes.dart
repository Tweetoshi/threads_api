enum Scope {
  /// Required for all Threads endpoints.
  threadsBasic('threads_basic'),

  /// Required for Threads publishing endpoints only.
  threadsContentPublish('threads_content_publish'),

  /// Required for making POST calls to reply endpoints.
  threadsManageReplies('threads_manage_replies'),

  /// Required for making GET calls to reply endpoints.
  threadsReadReplies('threads_read_replies'),

  /// Required for making GET calls to insights endpoints.
  threadsManageInsights('threads_manage_insights'),

  /// Required for making GET calls to keyword search endpoints.
  threadsKeywordSearch('threads_keyword_search'),

  /// Required for making DELETE calls to delete endpoints.
  threadsDelete('threads_delete');

  /// The actual string value of the scope
  final String value;

  const Scope(this.value);

  /// Returns the scope associated with the given [value].
  static Scope valueOf(final String value) {
    for (final scope in values) {
      if (scope.value == value) {
        return scope;
      }
    }

    throw ArgumentError('Invalid scope value: $value');
  }
}
