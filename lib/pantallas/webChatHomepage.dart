//'mateapp' creates a template of our static view (stateless)
import 'package:flutter/material.dart';
import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/lot.dart';

import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/userChat.dart';
import 'package:rlbasic/pantallas/webChat.dart';

//i think for the moment navigator is not essential because pageroute
import 'package:rlbasic/my_navigator.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/lotServices.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:scoped_model/scoped_model.dart';

ChatModel model = GlobalData.getInstance()!.getChatModel();
List<Lot> lots = [];

//import two models: user with chatmodel (sockets) & messages (webChat)

//relleno para commit
//on the other 'statefulW' create a statefull widget (reactive)
//statefull widget only takes one class
class AllChatsPage extends StatefulWidget {
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }

  void friendClicked(UserChat friend) async{
    await GlobalData.getInstance()?.setFriend(friend);
    model.chatIDvect = [model.myId,friend.id];
    model.chatIDvect.sort();
    model.chatID = model.chatIDvect[0].toString()+model.chatIDvect[1].toString();
    print("ChatID");
    print(model.chatID);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SmartStock Chat'),
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(icon: Icon(Icons.add_circle_rounded), text: 'CHATS'),
            Tab(icon: Icon(Icons.add_comment_outlined), text: 'Añadir a..')
          ]),
        ),
        body: TabBarView(
          children: [
            Center(child: Container()),//ChatList()),
            Center(child: Container()),//PonerAmigos()),
          ],
        )
      )
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }








}

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  void friendClicked(UserChat friend) {
    GlobalData.getInstance()?.setFriend(friend);
    model.chatIDvect = [model.myId, friend.id];
    model.chatIDvect.sort();
    model.chatID =
        model.chatIDvect[0].toString() + model.chatIDvect[1].toString();
    MyNavigator.goToWebChat(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        var alert = AlertDialog(
                          title: const Text('Cerrar sesión'),
                          content: new SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("¿Estas seguro?"),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  model.friendList!.removeAt(index);
                                });
                                UserServices()
                                    .deleteFriend(globalData.id, friend.id);
                                //enviar location y id delivery a mapas
                                Navigator.pop(context);
                                Navigator.pop(context);
                                MyNavigator.goToWebChatHomepage(context);
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Aceptar'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop('Cancelar');
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Cancelar'),
                            )
                          ],
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => alert
                        );
                      }
                  ),
                  subtitle: Text('Un poco de mensaje'),
                )
              ),
            );
          },
        ),
      );
    }
    
  }
}

class PonerAmigos extends StatefulWidget {
  const PonerAmigos({Key? key}) : super(key: key);

  @override
  _PonerAmigosState createState() => _PonerAmigosState();
}

class _PonerAmigosState extends State<PonerAmigos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LotServices().getLotListByUser(globalData.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          lots = snapshot.data;
          if (lots.isNotEmpty) {
            return SizedBox(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: lots.length,
                itemBuilder: (context, index) {
                  var friend = (lots[index].businessItem);
                  return GestureDetector(
                    //popUp con info de la empresa
                    //onTap: () => friendClicked(friend),
                    child: Card(
                        color: Colors.cyan[50],
                        child: ListTile(
                          leading: Icon(Icons.account_circle_sharp),
                          title: Text('${friend.userName.toString()}'),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  UserServices()
                                      .putFriend(globalData.id, friend.id);
                                  lots.removeAt(index);
                                });
                                PonerAmigos();
                              }),
                          subtitle: Text(friend.email),
                        )),
                  );
                },
              ),
            );
          } else {
            print('no hay nada');
            return Center(
                child: Text(
              'No se han encontrado personas a añadir',
            ));
          }
        } else if (snapshot.hasError) {
          return ListTile(title: Text('Ha habido un error :('));
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }
}
