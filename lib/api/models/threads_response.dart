class ThreadsResponse<D> {
  /// Creates a new instance of [ThreadsResponse].
  const ThreadsResponse({
    required this.beforeCursor,
    required this.afterCursor,
    required this.data,
  });

  // Cursor for pagination
  final String? beforeCursor;

  // Cursor for pagination
  final String? afterCursor;

  /// The data returned from the API.
  final D data;

  /// Converts the response to a JSON format.
  Map<String, dynamic> toJson() => data is List
      ? {
          'data': (data as List).map((e) => e.toJson()).toList(),
          'beforeCursor': beforeCursor,
          'afterCursor': afterCursor,
        }
      : {
          'data': (data as dynamic).toJson(),
          'beforeCursor': beforeCursor,
          'afterCursor': afterCursor,
        };

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

    buffer.write('beforeCursor: $beforeCursor, ');
    buffer.write('afterCursor: $afterCursor, ');
    buffer.write('data: $data');
    buffer.write(')');

    return buffer.toString();
  }
}
