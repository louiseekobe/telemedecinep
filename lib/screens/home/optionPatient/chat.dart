import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medecineapp/models/datauser.dart';
import 'package:medecineapp/screens/home/methode_crud.dart';
import 'package:medecineapp/screens/home/optionPatient/recherche_medecin.dart';
import 'package:medecineapp/shared/constant.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String nameUser;
  final String idMedecin;

  Chat({this.chatRoomId, this.nameUser, this.idMedecin});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);

  final _formkey = GlobalKey<FormState>();
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          message:
                              snapshot.data.documents[index].data["message"],
                          sendByMe: widget.nameUser ==
                              snapshot.data.documents[index].data["sendBy"],
                        );
                      })
                ]))
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": widget.nameUser,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      MethodeCrud().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  void _showSettingsPanel() {
    int note = 0;
    Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(50),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Noter votre consultation entre 0 et 5',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFormField(
                    decoration: TextInputDecoration.copyWith(labelText: 'NOTE'),
                    validator: (val) => val.isEmpty ||
                            (int.parse(val) < 0) ||
                            (int.parse(val) > 5)
                        ? 'note incorrecte'
                        : null,
                    onChanged: (val) {
                      setState(() => note = int.parse(val));
                    },
                  ),
                  RaisedButton(
                    color: c3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      'VALIDER NOTATION',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        Firestore.instance
                            .collection('medecin')
                            .document(widget.idMedecin)
                            .updateData({'notation': note});
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    MethodeCrud().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0),
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: c3,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return RechercheMedecin();
                      }));
                    },
                    child: Text('RETOUR',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Text("ENVOYER MESSAGE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 80),
                color: Colors.white,
                child: chatMessages()),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: c3,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Message ...",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "img/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _showSettingsPanel();
                      },
                      child: Text(
                        'NOTER',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0xff997788), const Color(0x77997788)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
