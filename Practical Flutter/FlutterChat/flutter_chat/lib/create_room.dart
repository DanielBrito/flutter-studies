// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "app_drawer.dart";
import "connector.dart" as connector;

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key key}) : super(key: key);

  @override
  _CreateRoom createState() => _CreateRoom();
}

class _CreateRoom extends State {
  String _title = "";
  String _description = "";
  bool _private = false;
  double _maxPeople = 25;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(final BuildContext inContext) {
    print("## CreateRoom.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Scaffold(
            appBar: AppBar(title: const Text("Create Room")),
            drawer: AppDrawer(),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        // Hide soft keyboard.
                        FocusScope.of(inContext).requestFocus(FocusNode());
                        // Navigate back from this screen.
                        Navigator.of(inContext).pop();
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text("Save"),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        int maxPeople = _maxPeople.truncate();

                        print(
                            "_title=$_title, _description = $_description, _maxPeople = $maxPeople, "
                            "_private = $_private, creator = $model.userName");

                        connector.create(
                          _title,
                          _description,
                          maxPeople,
                          _private,
                          model.userName,
                          (inStatus, inRoomList) {
                            print(
                                "## CreateRoom.create: callback: inStatus=$inStatus, inRoomList=$inRoomList");

                            if (inStatus == "created") {
                              model.setRoomList(inRoomList);

                              FocusScope.of(inContext)
                                  .requestFocus(FocusNode());

                              Navigator.of(inContext).pop();
                            } else {
                              ScaffoldMessenger.of(inContext).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text("Sorry, that room already exists"),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.subject),
                    title: TextFormField(
                      decoration: const InputDecoration(hintText: "Name"),
                      validator: (String inValue) {
                        if (inValue.isEmpty || inValue.length > 14) {
                          return "Please enter a name no more than 14 characters long";
                        }
                        return null;
                      },
                      onSaved: (String inValue) {
                        setState(() {
                          _title = inValue;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      onSaved: (String inValue) {
                        setState(() {
                          _description = inValue;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text("Max\nPeople"),
                        Slider(
                          min: 0,
                          max: 99,
                          value: _maxPeople,
                          onChanged: (double inValue) {
                            setState(() {
                              _maxPeople = inValue;
                            });
                          },
                        ),
                      ],
                    ),
                    trailing: Text(_maxPeople.toStringAsFixed(0)),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text("Private"),
                        Switch(
                          value: _private,
                          onChanged: (inValue) {
                            setState(() {
                              _private = inValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
