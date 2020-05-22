import 'package:chatbot/dio_server.dart';
import 'package:chatbot/models/chat_message.dart';
import 'package:chatbot/widgets/chat_message_list_item.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _messageList = <ChatMessage>[];
  final _controllerText = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controllerText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Chatbot - User'),
      ),
      body: Column(
        children: <Widget>[
          _buildList(),
          Divider(height: 1.0),
          _buildUserInput(),
        ],
      ),
    );
  }


  Widget _buildList() {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => ChatMessageListItem(chatMessage: _messageList[index]),
        itemCount: _messageList.length,
      ),
    );
  }

  Future _dialogRequest({String query}) async {


    _addMessage(
        name: 'Chatbot',
        text: 'Writing...',
        type: ChatMessageType.received);

      final String response = await server.postReq(query);

    setState(() {
      _messageList.removeAt(0);
    });


    _addMessage(
        name: 'Chatbot',
        text: response ?? '',
        type: ChatMessageType.received);
  }


  void _sendMessage({String text}) {
    _controllerText.clear();
    _addMessage(name: 'User', text: text, type: ChatMessageType.sent);
  }


  void _addMessage({String name, String text, ChatMessageType type}) {
    var message = ChatMessage(
        text: text, name: name, type: type);
    setState(() {
      _messageList.insert(0, message);
    });

    if (type == ChatMessageType.sent) {
      _dialogRequest(query: message.text);
    }
  }


  Widget _buildTextField() {
    return new Flexible(
      child: new TextField(
        controller: _controllerText,
        decoration: new InputDecoration.collapsed(
          hintText: "Message",
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return new Container(
      margin: new EdgeInsets.only(left: 8.0),
      child: new IconButton(
          icon: new Icon(Icons.send, color: Theme.of(context).accentColor),
          onPressed: () {
            if (_controllerText.text.isNotEmpty) {
              _sendMessage(text: _controllerText.text);
            }
          }),
    );
  }


  Widget _buildUserInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          _buildTextField(),
          _buildSendButton(),
        ],
      ),
    );
  }



}
