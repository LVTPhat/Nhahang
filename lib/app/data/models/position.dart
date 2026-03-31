class PositionModel {
  String? name, id;
  int? number;
  PositionModel({this.name, this.number});

  PositionModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.id = json['id'];
    this.number = json['number'];
  }
}
