import 'package:gitfeed/api/networking.dart';

class RepositoryRequest implements NetworkRequest {
  final int nextID;

  RepositoryRequest({this.nextID});

  @override
  String host = "api.github.com";

  @override
  String path = "repositories";

  @override
  NetworkMethod method = NetworkMethod.GET;

  @override
  EncodingType encodingType = EncodingType.QueryString;

  @override
  Map<String, dynamic> parameters() {
    if (nextID == null) {
      return {};
    }

    return {
      "since": nextID.toString(),
    };
  }
}
