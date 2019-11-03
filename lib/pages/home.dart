import 'package:flutter/material.dart';
import 'package:oneapp/services/socket.dart' as socket;

class Home extends StatelessWidget {
  hello() async {
    try {
      var result = await socket.connect('ws://localhost:3401');
      print(result);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            heightFactor: 1,
            child: Container(
              color: Color(0xff161f27),
              child: OutlineButton(
                child: Text(
                  'Say Hello',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => hello(),
                hoverColor: Color(0xff324759),
                borderSide: BorderSide(
                  color: Color(0xff0096bfab),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xff202b38),
    );
  }
}
