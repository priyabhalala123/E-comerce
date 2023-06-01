import 'dart:convert';

List<ImagesModel> getImagesModellFromJson(String str) => List<ImagesModel>.from(
    json.decode(str).map((x) => ImagesModel.fromJson(x)));

// String getImagesModelToJson(List<ImagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class ImagesModel {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  ImagesModel(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}
