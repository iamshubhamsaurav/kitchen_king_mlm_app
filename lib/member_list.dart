import 'package:cloud_firestore/cloud_firestore.dart';
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
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('members').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberPage(
                                isAdmin: true,
                                document: document,
                              ),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        // leading: Text("ID: ${document['id']}"),
                        leading: Icon(
                          Icons.person,
                          size: 60,
                        ),
                        title: new Text(document['applicantName'],
                            style: TextStyle(fontSize: 17)),
                        subtitle: new Text("Mobile: ${document['mobileNo']}"),
                        trailing: Icon(Icons.dashboard),
                      ),
                      Divider(
                        height: 0,
                        color: Colors.black54,
                      )
                    ],
                  );
                }).toList(),
              );
          }
        },
      )),
    );
  }
}
