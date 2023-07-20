class DetailsModal {
  String? id;
  String? name;
  String? areaName;
  String? city;
  String? contactNumber;
  String? whatsappNumber;
  String? address;
  String? banner;
  List<String>? images;

  DetailsModal(
      {this.id,
        this.name,
        this.areaName,
        this.city,
        this.contactNumber,
        this.whatsappNumber,
        this.address,
        this.banner,
        this.images});

  DetailsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaName = json['areaName'];
    city = json['city'];
    contactNumber = json['contactNumber'];
    whatsappNumber = json['whatsappNumber'];
    address = json['address'];
    banner = json['banner'];
    images = json['images'].cast<String>();
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
    data['images'] = this.images;
    return data;
  }
}
