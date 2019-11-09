import 'package:flutter/material.dart';
import 'package:oneapp/services/socket.dart' as socket;

class Home extends StatelessWidget {
  hello() async {
    try {
      var callZome = await socket.connect('ws://localhost:3401');
      var result =
          await callZome('test-instance', 'hello', 'hello_holo', {'args': {}});
      print(result);
    } catch (e) {
      print(e);
    }
  }

  retrievePerson(String address) async {
    var callZome = await socket.connect('ws://localhost:3401');
    var result = await callZome('test-instance', 'hello', 'retrieve_person', {
      'args': {'address': address}
    });
    print(result);
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
                onPressed: () => retrievePerson(
                    'QmdnRuHcnFAUta5DH3x6bM9WTfouMrDuieAWYEc67xoJ2G'),
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
