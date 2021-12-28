// @dart=2.9

import "dart:convert";
import "package:flutter_socket_io/flutter_socket_io.dart";
import "package:flutter_socket_io/socket_io_manager.dart";
import "package:flutter/material.dart";

import "model.dart" show FlutterChatModel, model;

String serverURL = "http://192.168.1.32";

SocketIO _io;

void showPleaseWait() {
  print("## Connector.showPleaseWait()");

  showDialog(
    context: model.rootBuildContext,
    barrierDismissible: false,
    builder: (BuildContext inDialogContext) {
      return Dialog(
        child: Container(
          width: 150,
          height: 150,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(color: Colors.blue[200]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child:
                      CircularProgressIndicator(value: null, strokeWidth: 10),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Center(
                  child: Text(
                    "Please wait, contacting server...",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void hidePleaseWait() {
  print("## Connector.hidePleaseWait()");

  Navigator.of(model.rootBuildContext).pop();
}

void connectToServer(final Function inCallback) {
  print("## Connector.connectToServer(): serverURL = $serverURL");

  _io = SocketIOManager().createSocketIO(
    serverURL,
    "/",
    query: "",
    socketStatusCallback: (inData) {
      print("## Connector.connectToServer(): callback: inData = $inData");

      if (inData == "connect") {
        print("## Connector.connectToServer(): callback: Connected to server");

        _io.subscribe("newUser", newUser);
        _io.subscribe("created", created);
        _io.subscribe("closed", closed);
        _io.subscribe("joined", joined);
        _io.subscribe("left", left);
        _io.subscribe("kicked", kicked);
        _io.subscribe("invited", invited);
        _io.subscribe("posted", posted);

        inCallback();
      }
    },
  );

  _io.destroy();

  _io = SocketIOManager().createSocketIO(
    serverURL,
    "/",
    query: "",
    socketStatusCallback: (inData) {
      print("## Connector.connectToServer(): callback: inData = $inData");

      if (inData == "connect") {
        print("## Connector.connectToServer(): callback: Connected to server");

        inCallback();
      }
    },
  );

  _io.init();
  _io.connect();
}

void validate(final String inUserName, final String inPassword,
    final Function inCallback) {
  print(
      "## Connector.validate(): inUserName = $inUserName, inPassword = $inPassword");

  showPleaseWait();

  _io.sendMessage(
    "validate",
    "{ \"userName\" : \"$inUserName\", \"password\" : \"$inPassword\" }",
    (inData) {
      print("## Connector.validate(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.validate(): callback: response = $response");

      hidePleaseWait();

      inCallback(response["status"]);
    },
  );
}

void listRooms(final Function inCallback) {
  print("## Connector.listRooms()");

  showPleaseWait();

  _io.sendMessage(
    "listRooms",
    "{}",
    (inData) {
      print("## Connector.listRooms(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.listRooms(): callback: response = $response");

      hidePleaseWait();

      inCallback(response);
    },
  );
}

void create(
    final String inRoomName,
    final String inDescription,
    final int inMaxPeople,
    final bool inPrivate,
    final String inCreator,
    final Function inCallback) {
  print(
      "## Connector.create(): inRoomName = $inRoomName, inDescription = $inDescription, "
      "inMaxPeople = $inMaxPeople, inPrivate = $inPrivate, inCreator = $inCreator");

  showPleaseWait();

  _io.sendMessage(
    "create",
    "{ \"roomName\" : \"$inRoomName\", \"description\" : \"$inDescription\", "
        "\"maxPeople\" : $inMaxPeople, \"private\" : $inPrivate, \"creator\" : \"$inCreator\" }",
    (inData) {
      print("## Connector.create(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.create(): callback: response = $response");

      hidePleaseWait();

      inCallback(response["status"], response["rooms"]);
    },
  );
}

void join(final String inUserName, final String inRoomName,
    final Function inCallback) {
  print(
      "## Connector.join(): inUserName = $inUserName, inRoomName = $inRoomName");

  showPleaseWait();

  _io.sendMessage(
    "join",
    "{ \"userName\" : \"$inUserName\", \"roomName\" : \"$inRoomName\"}",
    (inData) {
      print("## Connector.join(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.join(): callback: response = $response");

      hidePleaseWait();

      inCallback(response["status"], response["room"]);
    },
  );
}

void leave(final String inUserName, final String inRoomName,
    final Function inCallback) {
  print(
      "## Connector.leave(): inUserName = $inUserName, inRoomName = $inRoomName");

  showPleaseWait();

  _io.sendMessage(
    "leave",
    "{ \"userName\" : \"$inUserName\", \"roomName\" : \"$inRoomName\"}",
    (inData) {
      print("## Connector.leave(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.listUsers(): callback: response = $response");

      hidePleaseWait();

      inCallback();
    },
  );
}

void listUsers(final Function inCallback) {
  print("## Connector.listUsers()");

  showPleaseWait();

  _io.sendMessage(
    "listUsers",
    "{}",
    (inData) {
      print("## Connector.listUsers(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      print("## Connector.listUsers(): callback: response = $response");

      hidePleaseWait();

      inCallback(response);
    },
  );
}

void invite(final String inUserName, final String inRoomName,
    final String inInviterName, final Function inCallback) {
  print(
      "## Connector.invite(): inUserName = $inUserName, inRoomName = $inRoomName, inInviterName = $inInviterName");

  showPleaseWait();

  _io.sendMessage(
    "invite",
    "{ \"userName\" : \"$inUserName\", \"roomName\" : \"$inRoomName\", "
        "\"inviterName\" : \"$inInviterName\" }",
    (inData) {
      print("## Connector.invite(): callback: inData = $inData");

      hidePleaseWait();

      inCallback();
    },
  );
}

void post(final String inUserName, final String inRoomName,
    final String inMessage, final Function inCallback) {
  print(
      "## Connector.post(): inUserName = $inUserName, inRoomName = $inRoomName, inMessage = $inMessage");

  showPleaseWait();

  _io.sendMessage(
    "post",
    "{ \"userName\" : \"$inUserName\", \"roomName\" : \"$inRoomName\", "
        "\"message\" : \"$inMessage\" }",
    (inData) {
      print("## Connector.post(): callback: inData = $inData");

      Map<String, dynamic> response = jsonDecode(inData);

      hidePleaseWait();

      inCallback(response["status"]);
    },
  );
}

void close(final String inRoomName, final Function inCallback) {
  print("## Connector.close(): inRoomName = $inRoomName");

  showPleaseWait();

  _io.sendMessage(
    "close",
    "{ \"roomName\" : \"$inRoomName\" }",
    (inData) {
      print("## Connector.close(): callback: inData = $inData");

      hidePleaseWait();

      inCallback();
    },
  );
}

void kick(final String inUserName, final String inRoomName,
    final Function inCallback) {
  print(
      "## Connector.kick(): inUserName = $inUserName, inRoomName = $inRoomName");

  showPleaseWait();

  _io.sendMessage(
    "kick",
    "{ \"userName\" : \"$inUserName\", \"roomName\" : \"$inRoomName\" }",
    (inData) {
      print("## Connector.kick(): callback: inData = $inData");

      hidePleaseWait();

      inCallback();
    },
  );
}

void newUser(inData) {
  print("## Connector.newUser(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.newUser(): payload = $payload");

  model.setUserList(payload);
}

void created(inData) {
  print("## Connector.created(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.created(): payload = $payload");

  model.setRoomList(payload);
}

void closed(inData) {
  print("## Connector.closed(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.closed(): payload = $payload");

  model.setRoomList(payload);

  if (payload["roomName"] == model.currentRoomName) {
    model.removeRoomInvite(payload["roomName"]);
    model.setCurrentRoomUserList({});
    model.setCurrentRoomName(FlutterChatModel.DEFAULT_ROOM_NAME);
    model.setCurrentRoomEnabled(false);

    model.setGreeting("The room you were in was closed by its creator.");

    Navigator.of(model.rootBuildContext)
        .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
  }
}

void joined(inData) {
  print("## Connector.joined(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.joined(): payload = $payload");

  if (model.currentRoomName == payload["roomName"]) {
    model.setCurrentRoomUserList(payload["users"]);
  }
}

void left(inData) {
  print("## Connector.left(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.left(): payload = $payload");

  if (model.currentRoomName == payload["room"]["roomName"]) {
    model.setCurrentRoomUserList(payload["room"]["users"]);
  }
}

void kicked(inData) {
  print("## Connector.kicked(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);
  print("## Connector.kicked(): payload = $payload");

  model.removeRoomInvite(payload["roomName"]);
  model.setCurrentRoomUserList({});
  model.setCurrentRoomName(FlutterChatModel.DEFAULT_ROOM_NAME);
  model.setCurrentRoomEnabled(false);

  model.setGreeting("What did you do?! You got kicked from the room! D'oh!");

  Navigator.of(model.rootBuildContext)
      .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
}

void invited(inData) async {
  print("## Connector.invited(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);

  print("## Connector.invited(): payload = $payload");

  String roomName = payload["roomName"];
  String inviterName = payload["inviterName"];

  model.addRoomInvite(roomName);

  ScaffoldMessenger.of(model.rootBuildContext).showSnackBar(
    SnackBar(
      backgroundColor: Colors.amber,
      duration: const Duration(seconds: 60),
      content: Text(
          "You've been invited to the room '$roomName' by user '$inviterName'.\n\n"
          "You can enter the room from the lobby."),
      action: SnackBarAction(label: "Ok", onPressed: () {}),
    ),
  );
}

void posted(inData) {
  print("## Connector.posted(): inData = $inData");

  Map<String, dynamic> payload = jsonDecode(inData);
  print("## Connector.posted(): payload = $payload");

  // If the user is currently in the room then add message to room's message list.
  if (model.currentRoomName == payload["roomName"]) {
    model.addMessage(payload["userName"], payload["message"]);
  }
}
