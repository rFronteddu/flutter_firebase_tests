import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasechat/components/chat_bubble.dart';
import 'package:firebasechat/components/my_text_field.dart';
import 'package:firebasechat/services/auth/auth_service.dart';
import 'package:firebasechat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // for textfield focus
  FocusNode myFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    super.initState();
    myFocus.addListener(() {
      if (myFocus.hasFocus) {
        // cause a delay for the keyboard to show up and then scroll down
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
    // wait a bit for listview to be built
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocus.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    // if there is something to send..
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(
        children: [
          // all messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return Text("Error");
        }

        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        // return list view
        return ListView(
          controller: _scrollController,
          children:
          snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message ot the right if sender is the current user, otherwise left
    var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //   textfield should take most of the space
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscure: false,
              textController: _messageController,
              focusNode: myFocus,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 25),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
          //
        ],
      ),
    );
  }
}
