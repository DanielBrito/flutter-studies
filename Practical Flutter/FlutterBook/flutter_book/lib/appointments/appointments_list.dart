import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:scoped_model/scoped_model.dart";
import "package:intl/intl.dart";
import "package:flutter_calendar_carousel/flutter_calendar_carousel.dart";
import "package:flutter_calendar_carousel/classes/event.dart";
import "package:flutter_calendar_carousel/classes/event_list.dart";

import "appointments_db_worker.dart";
import "appointments_model.dart"
    show Appointment, AppointmentsModel, appointmentsModel;

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("## AppointmentsList.build()");

    // The list of dates with appointments.
    EventList<Event> _markedDateMap = EventList(events: {});

    for (int i = 0; i < appointmentsModel.entityList.length; i++) {
      Appointment appointment = appointmentsModel.entityList[i];
      List dateParts = appointment.apptDate.split(",");

      DateTime apptDate = DateTime(int.parse(dateParts[0]),
          int.parse(dateParts[1]), int.parse(dateParts[2]));

      _markedDateMap.add(
        apptDate,
        Event(
          date: apptDate,
          icon: Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
        ),
      );
    }

    return ScopedModel<AppointmentsModel>(
      model: appointmentsModel,
      child: ScopedModelDescendant<AppointmentsModel>(
        builder: (context, inChild, inModel) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                appointmentsModel.entityBeingEdited = Appointment();

                DateTime now = DateTime.now();

                appointmentsModel.entityBeingEdited.apptDate =
                    "${now.year},${now.month},${now.day}";

                appointmentsModel.setChosenDate(
                    DateFormat.yMMMMd("en_US").format(now.toLocal()));

                appointmentsModel.setApptTime("");

                appointmentsModel.setStackIndex(1);
              },
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: CalendarCarousel<Event>(
                      thisMonthDayBorderColor: Colors.grey,
                      daysHaveCircularBorder: false,
                      markedDatesMap: _markedDateMap,
                      onDayPressed: (DateTime inDate, List<Event> inEvents) {
                        _showAppointments(inDate, context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Show a bottom sheet to see the appointments for the selected day.
  void _showAppointments(DateTime inDate, BuildContext context) async {
    print(
        "## AppointmentsList._showAppointments(): inDate = $inDate (${inDate.year},${inDate.month},${inDate.day})");

    print(
        "## AppointmentsList._showAppointments(): appointmentsModel.entityList.length = "
        "${appointmentsModel.entityList.length}");

    print(
        "## AppointmentsList._showAppointments(): appointmentsModel.entityList = "
        "${appointmentsModel.entityList}");

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScopedModel<AppointmentsModel>(
          model: appointmentsModel,
          child: ScopedModelDescendant<AppointmentsModel>(
            builder: (context, child, model) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Text(
                          DateFormat.yMMMMd("en_US").format(inDate.toLocal()),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 24,
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: appointmentsModel.entityList.length,
                            itemBuilder:
                                (BuildContext inBuildContext, int inIndex) {
                              Appointment appointment =
                                  appointmentsModel.entityList[inIndex];

                              print(
                                  "## AppointmentsList._showAppointments().ListView.builder(): "
                                  "appointment = $appointment");

                              // Filter out any appointment that isn't for the specified date.
                              if (appointment.apptDate !=
                                  "${inDate.year},${inDate.month},${inDate.day}") {
                                return Container(height: 0);
                              }

                              print(
                                  "## AppointmentsList._showAppointments().ListView.builder(): "
                                  "INCLUDING appointment = $appointment");

                              String apptTime = "";

                              if (appointment.apptTime != "") {
                                List timeParts =
                                    appointment.apptTime.split(",");

                                TimeOfDay at = TimeOfDay(
                                    hour: int.parse(timeParts[0]),
                                    minute: int.parse(timeParts[1]));

                                apptTime = " (${at.format(context)})";
                              }

                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: .25,
                                    children: [
                                      SlidableAction(
                                        onPressed:
                                            (BuildContext contextLocal) async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder:
                                                (BuildContext inAlertContext) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Delete Note"),
                                                content: Text(
                                                    "Are you sure you want to delete ${appointment.title}?"),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Cancel"),
                                                    onPressed: () {
                                                      // Just hide dialog.
                                                      Navigator.of(
                                                              inAlertContext)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text("Delete"),
                                                    onPressed: () async {
                                                      await AppointmentsDBWorker
                                                          .db
                                                          .delete(
                                                              appointment.id);

                                                      Navigator.of(
                                                              inAlertContext)
                                                          .pop();

                                                      ScaffoldMessenger.of(
                                                              inAlertContext)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(
                                                              seconds: 2),
                                                          content: Text(
                                                              "Appointment deleted"),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );

                                                      // Reload data from database to update list.
                                                      appointmentsModel.loadData(
                                                          "appointments",
                                                          AppointmentsDBWorker
                                                              .db);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: "Delete",
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    color: Colors.grey.shade300,
                                    child: ListTile(
                                      title: Text(
                                          "${appointment.title} $apptTime"),
                                      subtitle: appointment.description == ""
                                          ? const Text("")
                                          : Text(appointment.description),
                                      onTap: () async {
                                        _editAppointment(context, appointment);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _editAppointment(
      BuildContext inContext, Appointment inAppointment) async {
    print(
        "## AppointmentsList._editAppointment(): inAppointment = $inAppointment");

    // Get the data from the database and send to the edit view.
    appointmentsModel.entityBeingEdited =
        await AppointmentsDBWorker.db.get(inAppointment.id);

    // Parse out the apptDate and apptTime, if any, and set them in the model:
    if (appointmentsModel.entityBeingEdited.apptDate == null) {
      appointmentsModel.setChosenDate("");
    } else {
      List dateParts = appointmentsModel.entityBeingEdited.apptDate.split(",");

      DateTime apptDate = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );

      appointmentsModel
          .setChosenDate(DateFormat.yMMMMd("en_US").format(apptDate.toLocal()));
    }

    if (appointmentsModel.entityBeingEdited.apptTime == "") {
      appointmentsModel.setApptTime("");
    } else {
      List timeParts = appointmentsModel.entityBeingEdited.apptTime.split(",");

      TimeOfDay apptTime = TimeOfDay(
          hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

      appointmentsModel.setApptTime(apptTime.format(inContext));
    }

    appointmentsModel.setStackIndex(1);
    Navigator.pop(inContext);
  }
}
