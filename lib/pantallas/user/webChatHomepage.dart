//'mateapp' creates a template of our static view (stateless) 
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//i think for the moment navigator is not essential because pageroute
//import '../../my_navigator.dart';

//import two models: user with chatmodel (sockets) & messages (webChat) 
import '../../models/user.dart';
import '../../models/chatmodel.dart';
//webChat = ChatPage
import './webChat.dart';

//on the other 'statefulW' create a statefull widget (reactive)
//statefull widget only takes one class
class AllChatsPage extends StatefulWidget {
  AllChatsPage({Key? key}) : super(key: key);

  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }

  void friendClicked(User friend){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          //we look this probem after
          return ChatPage(friend);
        },
      ),
    );
  }

  Widget buildAllChatList(){
    return ScopedModelDescendant<ChatModel>(
      builder: (context,child, model){
        return ListView.builder(
          itemCount: model.friendList.length, 
          itemBuilder: (BuildContext context, int index){
            User friend = model.friendList[index];
            return ListTile(
              title: Text(friend.userName),
              onTap: () => friendClicked(friend),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
      ),
      body: buildAllChatList(),
    );
  }
}