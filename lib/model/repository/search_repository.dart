import 'package:itunes_media_app/model/service/base_service.dart';
import 'package:itunes_media_app/model/service/media_service.dart';

import '../data_model/media_model/media_model.dart';

class SearchMediaRepository {
  final BaseService _mediaService = MediaService();

  Future<Media> fetchMediaList(String value) async {
    dynamic response = await _mediaService.getResponse(value);
    final jsonData = response;
    Media mediaList = Media.fromJson(jsonData);
    return mediaList;
  }
}
  