
import 'package:gitfeed/api/networking.dart';

class MeRequest implements NetworkRequest {

  @override
  EncodingType encodingType = EncodingType.QueryString;

  @override
  String host = "api.github.com";

  @override
  NetworkMethod method = NetworkMethod.GET;

  @override
  String path = "users/Geektree0101";

  @override
  Map<String, dynamic> parameters() {
    
    return {};
  }

}