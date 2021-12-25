import "../base_model.dart";

class Appointment {
  int id;
  String title;
  String description;
  String apptDate; // YYYY,MM,DD
  String apptTime; // HH,MM

  Appointment(
      {this.id = -1,
      this.title = "",
      this.description = "",
      this.apptDate = "",
      this.apptTime = ""});

  @override
  String toString() {
    return "{ id=$id, title=$title, description=$description, apptDate=$apptDate, apptDate=$apptTime }";
  }
}

class AppointmentsModel extends BaseModel {
  String apptTime = "";

  void setApptTime(String inApptTime) {
    apptTime = inApptTime;
    notifyListeners();
  }
}

AppointmentsModel appointmentsModel = AppointmentsModel();
