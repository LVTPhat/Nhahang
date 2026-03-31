class WorkdayModel {
  int? currentNumberStaff, maxNumberStaff;
  String? id;

  WorkdayModel({this.currentNumberStaff, this.maxNumberStaff, this.id});

  WorkdayModel.fromJson(Map<String, dynamic> json) {
    this.currentNumberStaff = json['staffnumber'];
    this.maxNumberStaff = json['maxstaffnumber'];
    this.id = json['id'];
  }
}
