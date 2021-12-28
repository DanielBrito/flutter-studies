const users = {};
const rooms = {};

const io = require("socket.io")(
  require("http")
    .createServer(function () {})
    .listen(80)
);

io.on("connection", (io) => {
  console.log("\n\nConnection established with a client");

  io.on("validate", (inData, inCallback) => {
    console.log("\n\nMSG: validate");

    console.log(`inData = ${JSON.stringify(inData)}`);

    const user = users[inData.userName];
    console.log(`user = ${JSON.stringify(user)}`);
    if (user) {
      if (user.password === inData.password) {
        console.log("User logged in");
        inCallback({ status: "ok" });
      } else {
        console.log("Password incorrect");
        inCallback({ status: "fail" });
      }
    } else {
      console.log("User created");
      console.log(`users = ${JSON.stringify(users)}`);
      users[inData.userName] = inData;
      console.log(`users = ${JSON.stringify(users)}`);

      io.broadcast.emit("newUser", users);
      inCallback({ status: "created" });
    }
  });

  io.on("invite", (inData, inCallback) => {
    console.log("\n\nMSG: invite", inData);

    io.broadcast.emit("invited", inData);
    inCallback({ status: "ok" });
  });

  io.on("kick", (inData, inCallback) => {
    console.log("\n\nMSG: kick", inData);

    const room = rooms[inData.roomName];
    console.log(`room = ${JSON.stringify(room)}`);
    const users = room.users;
    console.log(`users = ${JSON.stringify(users)}`);
    delete users[inData.userName];
    console.log(`users = ${JSON.stringify(users)}`);
    console.log(`room = ${JSON.stringify(room)}`);

    io.broadcast.emit("kicked", room);
    inCallback({ status: "ok" });
  });

  io.on("listUsers", (inData, inCallback) => {
    console.log("\n\nMSG: listUsers", inData);

    console.log("Returning: " + JSON.stringify(users));
    inCallback(users);
  });

  io.on("listRooms", (inData, inCallback) => {
    console.log("\n\nMSG: listRooms", rooms);

    console.log("Returning: " + JSON.stringify(rooms));
    inCallback(rooms);
  });

  io.on("create", (inData, inCallback) => {
    console.log("\n\nMSG: create", inData);

    if (rooms[inData.roomName]) {
      console.log("Room already exists");
      inCallback({ status: "exists" });
    } else {
      console.log("Creating room");
      inData.users = {};
      console.log(`inData: ${JSON.stringify(inData)}`);
      console.log(`rooms = ${JSON.stringify(rooms)}`);
      rooms[inData.roomName] = inData;
      console.log(`rooms = ${JSON.stringify(rooms)}`);

      io.broadcast.emit("created", rooms);
      inCallback({ status: "created", rooms: rooms });
    }
  });

  io.on("join", (inData, inCallback) => {
    console.log("\n\nMSG: join", inData);

    const room = rooms[inData.roomName];
    console.log(`room = ${JSON.stringify(room)}`);
    if (Object.keys(room.users).length >= rooms.maxPeople) {
      console.log("Room is full");
      inCallback({ status: "full" });
    } else {
      console.log(`room.users BEFORE = ${JSON.stringify(room.users)}`);
      room.users[inData.userName] = users[inData.userName];
      console.log(`room.users AFTER = ${JSON.stringify(room.users)}`);

      io.broadcast.emit("joined", room);

      inCallback({ status: "joined", room: room });
    }
  });

  io.on("leave", (inData, inCallback) => {
    console.log("\n\nMSG: leave", inData);

    const room = rooms[inData.roomName];
    delete room.users[inData.userName];

    io.broadcast.emit("left", room);
    inCallback({ status: "ok" });
  });

  io.on("close", (inData, inCallback) => {
    console.log("\n\nMSG: close", inData);

    delete rooms[inData.roomName];

    io.broadcast.emit("closed", { roomName: inData.roomName, rooms: rooms });
    inCallback(rooms);
  });

  io.on("post", (inData, inCallback) => {
    console.log("\n\nMSG: post", inData);

    io.broadcast.emit("posted", inData);
    inCallback({ status: "ok" });
  });
});

console.log("Server ready");
