// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "app_drawer.dart";

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext inContext) {
    print("## Home.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("FlutterChat"),
            ),
            drawer: const AppDrawer(),
            body: Center(
              child: Text(model.greeting),
            ),
          );
        },
      ),
    );
  }
}
