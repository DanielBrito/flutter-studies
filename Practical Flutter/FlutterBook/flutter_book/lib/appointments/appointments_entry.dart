import "dart:async";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "../utils.dart" as utils;
import "appointments_db_worker.dart";
import "appointments_model.dart" show AppointmentsModel, appointmentsModel;

class AppointmentsEntry extends StatelessWidget {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AppointmentsEntry({Key? key}) : super(key: key) {
    print("## AppointmentsEntry.constructor");

    _titleEditingController.addListener(() {
      appointmentsModel.entityBeingEdited.title = _titleEditingController.text;
    });

    _descriptionEditingController.addListener(() {
      appointmentsModel.entityBeingEdited.description =
          _descriptionEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("## AppointmentsEntry.build()");

    if (appointmentsModel.entityBeingEdited != null) {
      _titleEditingController.text = appointmentsModel.entityBeingEdited.title;
      _descriptionEditingController.text =
          appointmentsModel.entityBeingEdited.description;
    }

    return ScopedModel(
      model: appointmentsModel,
      child: ScopedModelDescendant<AppointmentsModel>(
        builder: (context, child, model) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      // Hide soft keyboard.
                      FocusScope.of(context).requestFocus(FocusNode());

                      // Go back to the list view.
                      model.setStackIndex(0);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () async {
                      _save(context, appointmentsModel);
                    },
                  )
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.subject),
                    title: TextFormField(
                      decoration: const InputDecoration(hintText: "Title"),
                      controller: _titleEditingController,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      controller: _descriptionEditingController,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: const Text("Date"),
                    subtitle: Text(appointmentsModel.chosenDate),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        // Request a date from the user.  If one is returned, store it.
                        String chosenDate = await utils.selectDate(
                            context,
                            appointmentsModel,
                            appointmentsModel.entityBeingEdited.apptDate);

                        appointmentsModel.entityBeingEdited.apptDate =
                            chosenDate;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.alarm),
                    title: const Text("Time"),
                    subtitle: Text(appointmentsModel.apptTime),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () => _selectTime(context),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _selectTime(BuildContext context) async {
    // Default to right now, assuming we're adding an appointment.
    TimeOfDay initialTime = TimeOfDay.now();

    // If editing an appointment, set the initialTime to the current apptTime, if any.
    if (appointmentsModel.entityBeingEdited.apptTime != "") {
      List timeParts = appointmentsModel.entityBeingEdited.apptTime.split(",");

      // Create a DateTime using the hours, minutes and a/p from the apptTime.
      initialTime = TimeOfDay(
          hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
    }

    // Now request the time.
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: initialTime);

    // If they didn't cancel, update it on the appointment being edited as well
    // as the apptTime field in the model so it shows on the screen.
    if (picked != null) {
      appointmentsModel.entityBeingEdited.apptTime =
          "${picked.hour},${picked.minute}";

      appointmentsModel.setApptTime(picked.format(context));
    }
  }

  // Save this contact to the database.
  void _save(BuildContext context, AppointmentsModel inModel) async {
    print("## AppointmentsEntry._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Creating a new appointment.
    if (inModel.entityBeingEdited.id == -1) {
      print(
          "## AppointmentsEntry._save(): Creating: ${inModel.entityBeingEdited}");

      await AppointmentsDBWorker.db.create(appointmentsModel.entityBeingEdited);
    } else {
      // Updating an existing appointment.
      print(
          "## AppointmentsEntry._save(): Updating: ${inModel.entityBeingEdited}");

      await AppointmentsDBWorker.db.update(appointmentsModel.entityBeingEdited);
    }

    // Reload data from database to update list.
    appointmentsModel.loadData("appointments", AppointmentsDBWorker.db);

    // Go back to the list view.
    inModel.setStackIndex(0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Appointment saved"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
