// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "connector.dart" as connector;

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext inContext) {
    print("## AppDrawer.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Drawer(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/drawback01.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Center(
                          child: Text(
                            model.userName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          model.currentRoomName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Lobby"),
                    onTap: () {
                      Navigator.of(inContext).pushNamedAndRemoveUntil(
                        "/Lobby",
                        ModalRoute.withName("/"),
                      );

                      connector.listRooms(
                        (inRoomList) {
                          print(
                              "## AppDrawer.listRooms: callback: inRoomList=$inRoomList");

                          model.setRoomList(inRoomList);
                        },
                      );
                    },
                  ),
                ),
                ListTile(
                  enabled: model.currentRoomEnabled,
                  leading: const Icon(Icons.forum),
                  title: const Text("Current Room"),
                  onTap: () {
                    Navigator.of(inContext).pushNamedAndRemoveUntil(
                      "/Room",
                      ModalRoute.withName("/"),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.face),
                  title: const Text("User List"),
                  onTap: () {
                    Navigator.of(inContext).pushNamedAndRemoveUntil(
                        "/UserList", ModalRoute.withName("/"));

                    connector.listUsers(
                      (inUserList) {
                        print(
                            "## AppDrawer.listUsers: callback: inUserList=$inUserList");

                        model.setUserList(inUserList);
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
