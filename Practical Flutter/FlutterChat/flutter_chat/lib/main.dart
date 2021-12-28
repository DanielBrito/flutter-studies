// @dart=2.9

import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "login_dialog.dart";
import "model.dart" show FlutterChatModel, model;
import "home.dart";
import "lobby.dart";
import "room.dart";
import "user_list.dart";
import "create_room.dart";

var credentials;
var exists;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  print("## main(): FlutterChat starting");

  startMeUp() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    model.docsDir = docsDir;

    var credentialsFile = File(join(model.docsDir.path, "credentials"));

    exists = await credentialsFile.exists();

    if (exists) {
      credentials = await credentialsFile.readAsString();
      print("## main(): credentials = $credentials");
    }

    runApp(FlutterChat());
  }

  startMeUp();
}

class FlutterChat extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    print("## FlutterChat.build()");

    return const MaterialApp(
      home: Scaffold(
        body: FlutterChatMain(),
      ),
    );
  }
}

class FlutterChatMain extends StatelessWidget {
  const FlutterChatMain({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext inContext) {
    print("## FlutterChatMain.build()");

    model.rootBuildContext = inContext;

    WidgetsBinding.instance?.addPostFrameCallback((_) => executeAfterBuild());

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return MaterialApp(
            initialRoute: "/",
            routes: {
              "/Lobby": (screenContext) => const Lobby(),
              "/Room": (screenContext) => const Room(),
              "/UserList": (screenContext) => const UserList(),
              "/CreateRoom": (screenContext) => const CreateRoom(),
            },
            home: const Home(),
          );
        },
      ),
    );
  }

  Future<void> executeAfterBuild() async {
    if (exists) {
      print(
          "## main(): Credential file exists, calling server with stored credentials");

      List credParts = credentials.split("============");
      LoginDialog().validateWithStoredCredentials(credParts[0], credParts[1]);
    } else {
      print(
          "## main(): Credential file does NOT exist, prompting for credentials");

      await showDialog(
        context: model.rootBuildContext,
        barrierDismissible: false,
        builder: (BuildContext inDialogContext) {
          return LoginDialog();
        },
      );
    }
  }
}
