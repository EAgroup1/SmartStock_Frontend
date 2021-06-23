//'mateapp' creates a template of our static view (stateless)
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/globalData.dart';

import 'package:rlbasic/models/message.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/userChat.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:scoped_model/scoped_model.dart';

//here we don't need the navigator
//import '../../my_navigator.dart';

//import two models: user with chatmodel (sockets) & messages (webChat)

//also import the model of message

class ChatPage extends StatefulWidget {
  UserChat? friend = GlobalData.getInstance()!.getFriend();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var text;
  ChatModel model = GlobalData.getInstance()!.getChatModel();
  String friendID = GlobalData.getInstance()!.getFriend().id;
  final TextEditingController textEditingController = TextEditingController();
  void callback(Message newmsg){
      setState(() { model.messages.add(newmsg); });
  }
  //one widget
  Widget buildSingleMessage(Message message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.senderID == globalData.id ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [Card(
        color: message.senderID == globalData.id ?Colors.cyan[50] : Colors.white,
        clipBehavior: Clip.antiAlias,
        child:Padding(
                    padding: const EdgeInsets.all(10),
                    child: Flexible(child: Text( message.text,
                      style: TextStyle(color: Colors.black.withOpacity(0.6))), fit: FlexFit.loose)))],
      );
  }

  Widget buildChatArea() {
    return new ScopedModel<ChatModel>(
        model: model,
        child: new Column(children: [
          new ScopedModelDescendant<ChatModel>(
            builder: (context, child, model) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(model.messages[index].receiverID == friendID ||model.messages[index].senderID == friendID){
                      return buildSingleMessage(model.messages[index]);
                    }
                    else{
                      return Container();
                    }
                  },
                ),
              );
            },
          ),
          new Text("Another widget that doesn't depend on the CounterModel")
        ])
        );
  }

  sendTxtButton() {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Row(          
          children: <Widget>[
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Escribe un mensaje', border: OutlineInputBorder()),
              onChanged: (val) {
                model.sendEscribiendo();
                text = val;
              },
            )),
            SizedBox(width: 10.0),
            SizedBox(
              height: 55.0,
              child: OutlinedButton(
                child: Icon(Icons.send_rounded),
                onPressed: () {
                  model.sendMessage(text);
                  Message newmsg = new Message(text,model.myId.toString(),GlobalData.getInstance()!.getFriend().id);
                  print("EL NUEVO MENSAJE ES EST REPUTO");
                  print(newmsg);
                  // The line below refresh the page and also add "newmsg" to model.messages. VERY IMPORTANT
                  setState(() { model.messages.add(newmsg); });
                  UserServices().addMessageList(model.myId.toString(), model.messages);
                },
              ),
            ),
          ],
        ));
  }

  //build all areas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.friend!.userName),
      actions: [Icon(Icons.more_vert)],),
      body: ListView(
        children: <Widget>[
          buildChatArea(),
          sendTxtButton(),
        ],
      ),
    );
  }
}
