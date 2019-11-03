import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                onPressed: () => print('hello'),
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
