class BannerModal {
  List<Banners>? banners;

  BannerModal({this.banners});

  BannerModal.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? id;
  String? smallText;
  String? image;

  Banners({this.id, this.smallText, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    smallText = json['small_text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['small_text'] = this.smallText;
    data['image'] = this.image;
    return data;
  }
}
