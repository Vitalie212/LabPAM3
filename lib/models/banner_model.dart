class BannerModel {
  final String title;
  final String description;
  final String image;

  BannerModel({
    required this.title,
    required this.description,
    required this.image,
  });

  // Factory constructor to create a BannerModel from JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
