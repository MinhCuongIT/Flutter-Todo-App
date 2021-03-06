
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/models/User.dart';
import 'package:todo_app/src/resources/auth_service.dart';

class DebuggingScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  onPressed: (){
                    AuthService().googleSignIn();
                  },
                  child: Text("Sign in"),
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  onPressed: (){
                    AuthService().signOut();
                  },
                  child: Text("Sign out"),
                )
              ],
            ),
            SizedBox(height: 40),
            Text(user.displayName)
          ],
        ),
      ),
    );
  }
}