class DropDownModal {
  List<String>? areas;

  DropDownModal({this.areas});

  DropDownModal.fromJson(Map<String, dynamic> json) {
    areas = json['areas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['areas'] = this.areas;
    return data;
  }
}
