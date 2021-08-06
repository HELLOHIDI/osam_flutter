import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_kakao/components/timeline.dart';
import 'package:flutter_kakao/components/chat_icon_button.dart';
import 'package:flutter_kakao/components/my_chat.dart';
import 'package:flutter_kakao/components/other_chat.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<MyChat> chats = [];
  FocusNode? myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFb2c7da),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TimeLine(time: "2021년 1월 1일 금요일"),
                      OtherChat(
                        name: "홍길동",
                        text: "새해 복 많이 받으세요.",
                        time: "오전 10:10",
                      ),
                      MyChat(
                        text: "선생님도 많이 받으십시오.",
                        time: "오후 2:15",
                      ),
                      ...List.generate(chats.length, (index) => chats[index]),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    ChatIconButton(
                      icon: Icon(FontAwesomeIcons.plusSquare),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: myFocusNode,
                        controller: _textController,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    ChatIconButton(icon: Icon(FontAwesomeIcons.smile)),
                    ChatIconButton(icon: Icon(FontAwesomeIcons.cog)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(value) {
    _textController.clear();
    setState(() {
      final currentTime = DateFormat("a K:m").format(new DateTime.now()).replaceAll("AM", "오전").replaceAll("PM", "오후");
      chats.add(MyChat(text: value, time: currentTime));
    });

    myFocusNode!.requestFocus();
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text("홍길동", style: Theme.of(context).textTheme.headline6),
      actions: [
        Icon(FontAwesomeIcons.search, size: 20),
        SizedBox(width: 25),
        Icon(FontAwesomeIcons.bars, size: 20),
        SizedBox(width: 25),
      ],
    );
  }
}
