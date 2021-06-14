//'mateapp' creates a template of our static view (stateless) 
import 'package:flutter/material.dart';
import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/globalData.dart';

import 'package:rlbasic/models/user.dart';

//i think for the moment navigator is not essential because pageroute
import 'package:rlbasic/my_navigator.dart';

//import two models: user with chatmodel (sockets) & messages (webChat) 

//relleno para commit
//on the other 'statefulW' create a statefull widget (reactive)
//statefull widget only takes one class
class AllChatsPage extends StatefulWidget {
  AllChatsPage({Key? key}) : super(key: key);
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  ChatModel model = GlobalData.getInstance()!.getChatModel();
  @override
  void initState() {
    super.initState();
  }

  void friendClicked(User friend){
    GlobalData.getInstance()?.setFriend(friend);
    MyNavigator.goToWebChat(context);
  }

  

  @override
  Widget build(BuildContext context) {
    buildAllChatList(){
      print(model.friendList?[0].toJson());
      if (model.friendList!.isEmpty){
        return Center(child: Text("No tienes lotes almacenados ¡Empieza a almacenar!"));
      }
      else{
        return SizedBox(
          width: 300,
          height: 300,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: model.friendList?.length,
            itemBuilder: (context, index) {
              var friend = model.friendList?[index];
              print(friend?.userName);
              print("descansito");
              print(friend?.id);
              return GestureDetector(
                onTap: () => friendClicked(friend!),
                child: Container(
                  height: 50,
                  color: Colors.amber[200],
                  child: Center(child: Text('Entry ${friend?.id.toString()}')),
                )
              );
            },
          ),
        );
      }
    }
    
    return Material(
      child: Form(
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: <Widget>[
            buildAllChatList(),
          ],
        ),
      )
    );
  }
}