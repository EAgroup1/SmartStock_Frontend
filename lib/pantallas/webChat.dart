//'mateapp' creates a template of our static view (stateless)
import 'package:flutter/material.dart';
import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/globalData.dart';

import 'package:rlbasic/models/message.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/userChat.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
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

  final TextEditingController textEditingController = TextEditingController();

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

  /*
  //chat
    Widget buildChatList(){
      return ScopedModelDescendant<ChatModel>(
        builder: (context, child, model){
          //receive the list of messages from one user with X id = ChatID
          List<Message> messages = model.getMessagesForChatID(widget.friend!.id);

          return Container(
            height: MediaQuery.of(context).size.height*0.75,
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index){
                return buildSingleMessage(messages[index]);
              },
            ),
          );
        },
      );
    }
    */

  /*Widget buildChatArea(){
      return ScopedModelDescendant<ChatModel>(
        builder: (context, child, model){
          return Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextField(
                    controller: textEditingController,
                  ),
                ),
                SizedBox(width: 10.0),
                FloatingActionButton(
                  onPressed: (){
                    model.sendMessage(textEditingController.text);
                  },
                  elevation: 0,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          );
        },
      );
    }*/
  Widget buildChatArea() {
    return new ScopedModel<ChatModel>(
        model: model,
        child: new Column(children: [
          // Create a ScopedModelDescendant. This widget will get the
          // CounterModel from the nearest ScopedModel<CounterModel>.
          // It will hand that model to our builder method, and rebuild
          // any time the CounterModel changes (i.e. after we
          // `notifyListeners` in the Model).
          new ScopedModelDescendant<ChatModel>(
            builder: (context, child, model) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  itemCount: model.messages?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildSingleMessage(model.messages![index]);
                  },
                ),
              );
            },
          ),
          new Text("Another widget that doesn't depend on the CounterModel")
        ]));
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
