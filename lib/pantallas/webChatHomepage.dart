//'mateapp' creates a template of our static view (stateless) 
import 'package:flutter/material.dart';
import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/globalData.dart';

import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/userChat.dart';
import 'package:rlbasic/pantallas/webChat.dart';

//i think for the moment navigator is not essential because pageroute
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/services/userServices.dart';

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

  void friendClicked(UserChat friend) async{
    await GlobalData.getInstance()?.setFriend(friend);
    model.chatIDvect = [model.myId,friend.id];
    model.chatIDvect.sort();
    model.chatID = model.chatIDvect[0].toString()+model.chatIDvect[1].toString();
    print("ChatID");
    print(model.chatID);
    MyNavigator.goToWebChat(context);
  }

  

  @override
  Widget build(BuildContext context) {
    buildAllChatList(){
      UserServices().getUserChat(GlobalData.getInstance()!.getId()).then((value) => {model.friendList=value});   
          
      if (model.friendList!.isEmpty){
        return Center(child: Text("No tienes amigos"));
      }
      else{
        return SizedBox(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: model.friendList?.length,
            itemBuilder: (context, index) {
              var friend = (model.friendList?[index]) as UserChat;
              return GestureDetector(
                onTap: () => friendClicked(friend),
                child: Card(
                  color: Colors.cyan[50],
                  child: ListTile(
                    leading: Icon(Icons.account_circle_sharp),
                    title: Text('${friend.userName.toString()}'),
                    trailing: Icon(Icons.delete),
                    subtitle: Text('Un poco de mensaje'),)),
                    
              );
            },
          ),
        );
      }
    }
    
    return DefaultTabController(length: 2, child:Scaffold(
      appBar: AppBar(
        title: Text('SmartStock Chat'),
        bottom:TabBar(indicatorColor: Colors.white,
        tabs: [
            Tab(icon: Icon(Icons.people_outline), text:'CHATS'),
            Tab(icon: Icon(Icons.add_comment_outlined), text:'Contactanos')
          ]),
      ),
      body: TabBarView(
        children: [
          Center(child:buildAllChatList()),
          Center(child: Text('No hay nada que mostrar'))
        ],
      )
    ));
  }
}