import 'package:flutter/material.dart';
import 'member_page.dart';
import 'add_member_page.dart';

class MemberList extends StatefulWidget {
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        centerTitle: true,
        title: Text(
          "Members",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMemberPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemberPage(isAdmin: true)),
                );
              },
              leading: Icon(
                Icons.person,
                size: 60,
              ),
              title: Text("member name : ${index + 1}"),
              subtitle: Text("Member Id"),
            );
          },
        ),
      ),
    );
  }
}
