import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "appointments_db_worker.dart";
import "appointments_list.dart";
import "appointments_entry.dart";
import "appointments_model.dart" show AppointmentsModel, appointmentsModel;

class Appointments extends StatelessWidget {
  Appointments({Key? key}) : super(key: key) {
    print("## Appointments.constructor");

    // Initial load of data.
    appointmentsModel.loadData("appointments", AppointmentsDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    print("## Appointments.build()");

    return ScopedModel<AppointmentsModel>(
      model: appointmentsModel,
      child: ScopedModelDescendant<AppointmentsModel>(
        builder: (context, child, model) {
          return IndexedStack(
            index: model.stackIndex,
            children: [
              const AppointmentsList(),
              AppointmentsEntry(),
            ],
          );
        },
      ),
    );
  }
}
