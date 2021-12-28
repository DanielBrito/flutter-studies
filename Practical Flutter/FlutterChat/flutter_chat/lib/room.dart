// @dart=2.9

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "model.dart" show FlutterChatModel, model;
import "app_drawer.dart";
import "connector.dart" as connector;

class Room extends StatefulWidget {
  const Room({Key key}) : super(key: key);

  @override
  _Room createState() => _Room();
}

class _Room extends State {
  bool _expanded = false;
  String _postMessage = "";

  final ScrollController _controller = ScrollController();
  final TextEditingController _postEditingController = TextEditingController();

  @override
  Widget build(final BuildContext inContext) {
    print("## Room.build()");

    return ScopedModel<FlutterChatModel>(
      model: model,
      child: ScopedModelDescendant<FlutterChatModel>(
        builder:
            (BuildContext inContext, Widget inChild, FlutterChatModel inModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.currentRoomName),
              actions: [
                PopupMenuButton(
                  onSelected: (inValue) {
                    if (inValue == "invite") {
                      _inviteOrKick(inContext, "invite");
                    } else if (inValue == "leave") {
                      connector.leave(
                        model.userName,
                        model.currentRoomName,
                        () {
                          model.removeRoomInvite(model.currentRoomName);
                          model.setCurrentRoomUserList({});
                          model.setCurrentRoomName(
                              FlutterChatModel.DEFAULT_ROOM_NAME);
                          model.setCurrentRoomEnabled(false);

                          Navigator.of(inContext).pushNamedAndRemoveUntil(
                              "/", ModalRoute.withName("/"));
                        },
                      );
                    } else if (inValue == "close") {
                      connector.close(
                        model.currentRoomName,
                        () {
                          Navigator.of(inContext).pushNamedAndRemoveUntil(
                              "/", ModalRoute.withName("/"));
                        },
                      );
                    } else if (inValue == "kick") {
                      _inviteOrKick(inContext, "kick");
                    }
                  },
                  itemBuilder: (BuildContext inPMBContext) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        value: "leave",
                        child: Text("Leave Room"),
                      ),
                      const PopupMenuItem(
                        value: "invite",
                        child: Text("Invite A User"),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          value: "close",
                          child: const Text("Close Room"),
                          enabled: model.creatorFunctionsEnabled),
                      PopupMenuItem(
                          value: "kick",
                          child: const Text("Kick User"),
                          enabled: model.creatorFunctionsEnabled)
                    ];
                  },
                ),
              ],
            ),
            drawer: const AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(6, 14, 6, 6),
              child: Column(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (inIndex, inExpanded) => setState(() {
                      _expanded = !_expanded;
                    }),
                    children: [
                      ExpansionPanel(
                        isExpanded: _expanded,
                        headerBuilder:
                            (BuildContext context, bool isExpanded) =>
                                const Text("  Users In Room"),
                        body: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Builder(
                            builder: (inBuilderContext) {
                              List<Widget> userList = [];
                              for (var user in model.currentRoomUserList) {
                                userList.add(Text(user["userName"]));
                              }
                              return Column(children: userList);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: model.currentRoomMessages.length,
                      itemBuilder: (inContext, inIndex) {
                        Map message = model.currentRoomMessages[inIndex];
                        return ListTile(
                          subtitle: Text(message["userName"]),
                          title: Text(message["message"]),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _postEditingController,
                          onChanged: (String inText) => setState(() {
                            _postMessage = inText;
                          }),
                          decoration: const InputDecoration.collapsed(
                              hintText: "Enter message"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.blue,
                          onPressed: () {
                            connector.post(
                              model.userName,
                              model.currentRoomName,
                              _postMessage,
                              (inStatus) {
                                print(
                                    "Room.post callback: inStatus = $inStatus");

                                if (inStatus == "ok") {
                                  model.addMessage(
                                      model.userName, _postMessage);
                                  _controller.jumpTo(
                                      _controller.position.maxScrollExtent);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _inviteOrKick(final BuildContext inContext, final String inInviteOrKick) {
    connector.listUsers(
      (inUserList) {
        print("## Room.listUsers: callback: inUserList=$inUserList");

        model.setUserList(inUserList);

        showDialog(
          context: inContext,
          builder: (BuildContext inDialogContext) {
            return ScopedModel<FlutterChatModel>(
              model: model,
              child: ScopedModelDescendant<FlutterChatModel>(
                builder: (BuildContext inContext, Widget inChild,
                    FlutterChatModel inModel) {
                  return AlertDialog(
                    title: Text("Select user to $inInviteOrKick"),
                    content: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite / 2,
                      child: ListView.builder(
                        itemCount: inInviteOrKick == "invite"
                            ? model.userList.length
                            : model.currentRoomUserList.length,
                        itemBuilder:
                            (BuildContext inBuildContext, int inIndex) {
                          Map user;

                          if (inInviteOrKick == "invite") {
                            user = model.userList[inIndex];
                          } else {
                            user = model.currentRoomUserList[inIndex];
                          }

                          if (user["userName"] == model.userName) {
                            return Container();
                          }

                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              border: Border(
                                  bottom: BorderSide(),
                                  top: BorderSide(),
                                  left: BorderSide(),
                                  right: BorderSide()),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [.1, .2, .3, .4, .5, .6, .7, .8, .9],
                                colors: [
                                  Color.fromRGBO(250, 250, 0, .75),
                                  Color.fromRGBO(250, 220, 0, .75),
                                  Color.fromRGBO(250, 190, 0, .75),
                                  Color.fromRGBO(250, 160, 0, .75),
                                  Color.fromRGBO(250, 130, 0, .75),
                                  Color.fromRGBO(250, 110, 0, .75),
                                  Color.fromRGBO(250, 80, 0, .75),
                                  Color.fromRGBO(250, 50, 0, .75),
                                  Color.fromRGBO(250, 0, 0, .75)
                                ],
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 10.0),
                            child: ListTile(
                              title: Text(user["userName"]),
                              onTap: () {
                                if (inInviteOrKick == "invite") {
                                  connector.invite(
                                      user["userName"],
                                      model.currentRoomName,
                                      model.userName, () {
                                    Navigator.of(inContext).pop();
                                  });
                                } else {
                                  connector.kick(
                                    user["userName"],
                                    model.currentRoomName,
                                    () {
                                      Navigator.of(inContext).pop();
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
