// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "app_drawer.dart";

class UserList extends StatelessWidget {
  const UserList({Key key}) : super(key: key);

  Widget build(final BuildContext inContext) {
    print("## UserList.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Scaffold(
            appBar: AppBar(title: Text("User List")),
            drawer: const AppDrawer(),
            body: GridView.builder(
              itemCount: model.userList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext inContext, int inIndex) {
                Map user = model.userList[inIndex];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GridTile(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Image.asset("assets/user.png"),
                          ),
                        ),
                        footer:
                            Text(user["userName"], textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
