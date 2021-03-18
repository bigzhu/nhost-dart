import 'package:json_annotation/json_annotation.dart';

part 'storage_api_types.g.dart';

/// Describes a file stored by Nhost.
///
/// The fields of this class can be used to fetch the file's contents ([key]),
/// as well as populate the headers of an HttpResponse if you were to serve
/// this file to a client.
@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class FileMetadata {
  FileMetadata({
    this.key,
    this.acceptRanges,
    this.lastModified,
    this.contentLength,
    this.eTag,
    this.contentType,
    this.nhostMetadata,
  });

  /// Path to file
  final String key;

  /// accept-ranges value for HTTP response header
  final String acceptRanges;

  /// last-modified  value for HTTP response header
  final DateTime lastModified;

  /// content-length value for HTTP response header
  final int contentLength;

  /// etag value for HTTP response header
  final String eTag;

  /// content-type value for HTTP response header
  final String contentType;

  /// Additional Nhost-specific metadata associated with this file
  @JsonKey(name: 'Metadata')
  final FileNhostMetadata nhostMetadata;

  static FileMetadata fromJson(dynamic json) {
    // TODO(https://github.com/nhost/hasura-backend-plus/issues/436): In
    // order to work around inconsistencies in the backend's naming of this
    // field, we duplicate.
    json['Key'] = json['Key'] ?? json['key'];
    return _$FileMetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileMetadataToJson(this);
}

/// Additional Nhost-specific metadata associated with a [FileMetadata]
/// instance.
@JsonSerializable(fieldRename: FieldRename.snake)
class FileNhostMetadata {
  FileNhostMetadata({this.token});

  /// TODO(shyndman): What is this?
  final String token;

  static FileNhostMetadata fromJson(dynamic json) =>
      _$FileNhostMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$FileNhostMetadataToJson(this);
}