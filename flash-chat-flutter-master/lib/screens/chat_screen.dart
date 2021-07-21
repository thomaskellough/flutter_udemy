import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseService firebaseService = FirebaseService();

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextcontroller = TextEditingController();
  User loggedInUser;
  String message;

  @override
  void initState() {
    super.initState();

    loggedInUser = firebaseService.getUser();
    print(loggedInUser.email);
    messageStream();
  }

  @override
  void dispose() {
    super.dispose();
    messageTextcontroller.dispose();
  }

  void messageStream() async {
    await for (var snapshot in firebaseService
        .getFireStoreInstance()
        .collection(firebaseService.fireStoreMessagesCollectionPath)
        .snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                firebaseService.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextcontroller,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextcontroller.clear();
                      var newMessage = NewMessage(
                          message: message, sender: loggedInUser.email);
                      var collection = firebaseService
                          .getFireStoreInstance()
                          .collection(
                              firebaseService.fireStoreMessagesCollectionPath);
                      collection.add({
                        newMessage.messageKey: message,
                        newMessage.senderKey: loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewMessage {
  final messageKey = 'message';
  final senderKey = 'sender';
  String message;
  String sender;

  NewMessage({@required this.message, @required this.sender});
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseService
          .getFireStoreInstance()
          .collection(firebaseService.fireStoreMessagesCollectionPath)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: kPrimaryColorLight,
          );
        }
        final messages = snapshot.data;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages.docs.reversed) {
          final messageData = message.data() as Map<String, dynamic>;
          final messageText = messageData['message'];
          final messageSender = messageData['sender'];
          final messageBubble =
              MessageBubble(text: messageText, sender: messageSender);
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            children: messageWidgets,
          ),
        );
        return null;
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final text;
  final sender;

  MessageBubble({@required this.text, @required this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: sender == firebaseService.getUser().email
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              sender,
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
          ),
          Material(
            color: sender == firebaseService.getUser().email
                ? kPrimaryColorLight
                : Colors.grey[300],
            elevation: 5.0,
            borderRadius: sender == firebaseService.getUser().email
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))
                : BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: sender == firebaseService.getUser().email
                      ? Colors.white
                      : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
