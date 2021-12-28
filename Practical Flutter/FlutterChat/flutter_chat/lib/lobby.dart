// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "app_drawer.dart";
import "connector.dart" as connector;

class Lobby extends StatelessWidget {
  const Lobby({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext inContext) {
    print("## Lobby.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Lobby"),
            ),
            drawer: const AppDrawer(),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(inContext, "/CreateRoom");
              },
            ),
            body: model.roomList.isEmpty
                ? const Center(
                    child: Text("There are no rooms yet. Why not add one?"),
                  )
                : ListView.builder(
                    itemCount: model.roomList.length,
                    itemBuilder: (BuildContext inBuildContext, int inIndex) {
                      Map room = model.roomList[inIndex];
                      String roomName = room["roomName"];

                      return Column(
                        children: [
                          ListTile(
                            leading: room["private"]
                                ? Image.asset("assets/private.png")
                                : Image.asset("assets/public.png"),
                            title: Text(roomName),
                            subtitle: Text(room["description"]),
                            onTap: () {
                              if (room["private"] &&
                                  !model.roomInvites.containsKey(roomName) &&
                                  room["creator"] != model.userName) {
                                ScaffoldMessenger.of(inBuildContext)
                                    .showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                        "Sorry, you can't enter a private room without an invite"),
                                  ),
                                );
                              } else {
                                connector.join(
                                  model.userName,
                                  roomName,
                                  (inStatus, inRoomDescriptor) {
                                    print(
                                        "## Lobby.joined callback: inStatus = $inStatus, inRoomDescriptor = $inRoomDescriptor");

                                    if (inStatus == "joined") {
                                      model.setCurrentRoomName(
                                          inRoomDescriptor["roomName"]);
                                      model.setCurrentRoomUserList(
                                          inRoomDescriptor["users"]);
                                      model.setCurrentRoomEnabled(true);
                                      model.clearCurrentRoomMessages();

                                      if (inRoomDescriptor["creator"] ==
                                          model.userName) {
                                        model.setCreatorFunctionsEnabled(true);
                                      } else {
                                        model.setCreatorFunctionsEnabled(false);
                                      }

                                      Navigator.pushNamed(inContext, "/Room");
                                    } else if (inStatus == "full") {
                                      ScaffoldMessenger.of(inBuildContext)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                          content:
                                              Text("Sorry, that room is full"),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
