import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chat.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  String datemessages = "";
  String showdate(String date){
    final now = DateTime.now();
    final moonLanding = DateTime.parse(date);
      if(moonLanding.hour<12){
        return '${moonLanding.hour}:${moonLanding.minute} am';
      }
      else{
        return '${moonLanding.hour}:${moonLanding.minute} pm';
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff242A37),
        appBar: AppBar(
          backgroundColor: const Color(0xff242A37),
          leading: IconButton(
            onPressed: null,
            icon: Icon(Icons.arrow_back,color: Color(0xffFFFFFF)),
          ),
          actions: [IconButton(onPressed: null, icon: Icon(Icons.add,color: Color(0xffFFFFFF)))],
        ),
        body: Column(
          children: [
            Container(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          'Messages',
                          style: TextStyle(fontSize: 30,color: Color(0xffFFFFFF)),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                height: 130,
                child: FutureBuilder(
                  future: _fetchUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.listuser.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(top: 15, left: 20),
                              width: 60,
                              height: 82,
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                              height: 60,
                                              width: 60,
                                              child: Image.network(snapshot
                                                  .data
                                                  .listuser[index]
                                                  .picture
                                                  .large)),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 12,
                                            width: 12,
                                            child: _statusButton(snapshot.data.listuser[index].status),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 9),
                                    height: 13,
                                    width: 63,
                                    child: Text(
                                      snapshot.data.listuser[index].name,
                                      style: TextStyle(fontSize: 10,color: Color(0xffFFFFFF)),
                                    ),
                                  )
                                ],
                              ));
                        },
                      );
                    } else {
                      return Container(
                        child: Text('Error'),
                      );
                    }
                  },
                )),
            Expanded(
                child: FutureBuilder(
              future: _fetchChat(),
               builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.listchat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 90,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipOval(
                                      child: Image.network(snapshot.data
                                          .listchat[index].user.picture.large),
                                    ),
                                    Positioned(
                                      child: _unreadCountButton(snapshot
                                          .data.listchat[index].unreadCount),
                                      right: 10,
                                      bottom: 10,
                                      width: 15,
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Expanded(flex: 1,child:
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 20,left: 10),
                                              child: Text(_formatText(snapshot.data.listchat[index].user.name), style: TextStyle(color: Color(0xffFFFFFF))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(showdate(snapshot.data.listchat[index].createdAt),style: TextStyle(color: Color(0xffFFFFFF)),),
                                            ),
                                          )
                                        ],
                                      )),
                                      Expanded(flex: 1,child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 4,left: 10),
                                            child: Text(_formatText(snapshot.data.listchat[index].text),style: TextStyle(color: Color(0xffFFFFFF),fontSize: 17),),
                                          ),
                                        ],
                                      )),
                                    ],
                                  )
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Container(
                    child: Text('Error'),
                  );
                }
              },
            )),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.home, color: Color(0xffFFFFFF)),),
                  IconButton(onPressed: null, icon: Icon(Icons.stream, color: Color(0xffFFFFFF)),),
                  IconButton(onPressed: null, icon: Icon(Icons.message, color: Color(0xffFFFFFF)),),
                  IconButton(onPressed: null, icon: Icon(Icons.notifications_active, color: Color(0xffFFFFFF)),),
                  IconButton(onPressed: null, icon: Icon(Icons.contact_page, color: Color(0xffFFFFFF)),),
                ],
              ),
            )
          ],
        ));
  }
String _formatText(String messages){
    if(messages.length >35){
      return messages.substring(0,35).trim();
    }
    else{
      return messages.trim();
    }

}
  Future<LISTUSER> _fetchUser() async {
    final json = await rootBundle.loadString('assets/jsons/users.json');
    final decoded = jsonDecode(json);
    debugPrint(decoded.toString());
    return (new LISTUSER.fromJson(decoded));
  }

  Future<LISTCHAT> _fetchChat() async {
    final json = await rootBundle.loadString('assets/jsons/chats.json');
    final decoded = jsonDecode(json);
    debugPrint(decoded.toString());
    return (new LISTCHAT.fromJson(decoded));
  }
  FloatingActionButton _statusButton(String status){
    if(status== "online"){
      return FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => {},
      );
    }
    else if(status== "offline"){
      return FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => {},
      );
    }
    else{
      return FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => {},
      );
    }

  }
  FloatingActionButton _unreadCountButton(int unreadCount){
    if(unreadCount == 0){
      return FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => {},

      );
    }
    else{
      return FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Center(
            child: Text(unreadCount.toString())
        ),
        onPressed: () => {},
      );
    }
  }
}

class statusButton extends StatelessWidget {
  const statusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: () => {},
    );
  }
}

