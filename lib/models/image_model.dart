class ImagesResponse {
  List<ImageModel>? images;
  String? error;

  ImagesResponse({this.images, this.error});

  factory ImagesResponse.fromJson(List<dynamic> json) {
    List<ImageModel> list = [];
    list = json.map((i) => ImageModel.fromJson(i)).toList();

    return ImagesResponse(images: list);
  }

  factory ImagesResponse.withError(String error) {
    return ImagesResponse(error: error);
  }
}

class ImageModel {
  String? id;
  String? description;
  ImageSizes? image;

  ImageModel({
    this.id,
    this.description,
    this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      description: json['description'] ?? json['alt_description'],
      image: ImageSizes.fromJson(json['urls']),
    );
  }
}

class ImageSizes {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;

  ImageSizes({this.raw, this.full, this.regular, this.small, this.thumb});

  factory ImageSizes.fromJson(Map<String, dynamic> json) {
    return ImageSizes(
        raw: json['raw'],
        full: json['full'],
        regular: json['regular'],
        small: json['small'],
        thumb: json['thumb']);
  }
}
