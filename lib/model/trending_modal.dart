class TrendingModal {
  List<Listings>? listings;

  TrendingModal({this.listings});

  TrendingModal.fromJson(Map<String, dynamic> json) {
    if (json['listings'] != null) {
      listings = <Listings>[];
      json['listings'].forEach((v) {
        listings!.add(new Listings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listings != null) {
      data['listings'] = this.listings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listings {
  String? id;
  String? name;
  String? areaName;
  String? city;
  String? contactNumber;
  String? whatsappNumber;
  String? address;
  String? banner;
  String? rating;

  Listings(
      {this.id,
        this.name,
        this.areaName,
        this.city,
        this.contactNumber,
        this.whatsappNumber,
        this.address,
        this.banner,
        this.rating});

  Listings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaName = json['areaName'];
    city = json['city'];
    contactNumber = json['contactNumber'];
    whatsappNumber = json['whatsappNumber'];
    address = json['address'];
    banner = json['banner'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['areaName'] = this.areaName;
    data['city'] = this.city;
    data['contactNumber'] = this.contactNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['address'] = this.address;
    data['banner'] = this.banner;
    data['rating'] = this.rating;
    return data;
  }
}
