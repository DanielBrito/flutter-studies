// @dart=2.9

import "dart:io";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

class FlutterChatModel extends Model {
  BuildContext rootBuildContext;

  Directory docsDir;

  String greeting = "";

  String userName = "";

  static const String DEFAULT_ROOM_NAME = "Not currently in a room";

  String currentRoomName = DEFAULT_ROOM_NAME;

  List currentRoomUserList = [];

  bool currentRoomEnabled = false;

  List currentRoomMessages = [];

  List roomList = [];

  List userList = [];

  bool creatorFunctionsEnabled = false;

  Map roomInvites = {};

  void setGreeting(final String inGreeting) {
    print("## FlutterChatModel.setGreeting(): inGreeting = $inGreeting");

    greeting = inGreeting;
    notifyListeners();
  }

  void setUserName(final String inUserName) {
    print("## FlutterChatModel.setUserName(): inUserName = $inUserName");

    userName = inUserName;
    notifyListeners();
  }

  void setCurrentRoomName(final String inRoomName) {
    print("## FlutterChatModel.setCurrentRoomName(): inRoomName = $inRoomName");

    currentRoomName = inRoomName;
    notifyListeners();
  }

  void setCreatorFunctionsEnabled(final bool inEnabled) {
    print(
        "## FlutterChatModel.setCreatorFunctionsEnabled(): inEnabled = $inEnabled");

    creatorFunctionsEnabled = inEnabled;
    notifyListeners();
  }

  void setCurrentRoomEnabled(final bool inEnabled) {
    print(
        "## FlutterChatModel.setCurrentRoomEnabled(): inEnabled = $inEnabled");

    currentRoomEnabled = inEnabled;
    notifyListeners();
  }

  void addMessage(final String inUserName, final String inMessage) {
    print(
        "## FlutterChatModel.addMessage(): inUserName = $inUserName, inMessage = $inMessage");

    currentRoomMessages.add({"userName": inUserName, "message": inMessage});
    notifyListeners();
  }

  void setRoomList(final Map inRoomList) {
    print("## FlutterChatModel.setRoomList(): inRoomList = $inRoomList");

    List rooms = [];

    for (String roomName in inRoomList.keys) {
      Map room = inRoomList[roomName];
      rooms.add(room);
    }

    roomList = rooms;
    notifyListeners();
  }

  void setUserList(final Map inUserList) {
    print("## FlutterChatModel.setUserList(): inUserList = $inUserList");

    List users = [];

    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }

    userList = users;
    notifyListeners();
  }

  void setCurrentRoomUserList(final Map inUserList) {
    print(
        "## FlutterChatModel.setCurrentRoomUserList(): inUserList = $inUserList");

    List users = [];

    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }

    currentRoomUserList = users;
    notifyListeners();
  }

  void addRoomInvite(final String inRoomName) {
    print("## FlutterChatModel.addRoomInvite(): inRoomName = $inRoomName");

    roomInvites[inRoomName] = true;
  }

  void removeRoomInvite(final String inRoomName) {
    print("## FlutterChatModel.removeRoomInvite(): inRoomName = $inRoomName");

    roomInvites.remove(inRoomName);
  }

  void clearCurrentRoomMessages() {
    print("## FlutterChatModel.clearCurrentRoomMessages()");

    currentRoomMessages = [];
  }
}

FlutterChatModel model = FlutterChatModel();
