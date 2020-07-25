import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MemberPage extends StatelessWidget {
  final bool isAdmin;
  final DocumentSnapshot document;
  MemberPage({Key key, @required this.isAdmin, @required this.document})
      : super(key: key);

  Widget buildKeyAndValueItem(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "$key:-",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Text(
              value,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ))
          ],
        ),
        Divider(height: 10, color: Colors.black87)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final companyIcon = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          child: Image.asset(
            'lib/assets/icon/launcher_icon.jpeg',
          ),
          // backgroundImage: AssetImage('lib/assets/logo.jpeg'),
          backgroundColor: Colors.grey,
          radius: 75.0,
//        child: Image.asset('assets/logo.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome!',
        style: TextStyle(fontSize: 28.0, color: Colors.black87),
      ),
    );

    final body = Container(
      color: Colors.white54,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            companyIcon,
            welcome,
            buildKeyAndValueItem("User Id", "${document['id']}"),
            buildKeyAndValueItem("Date of Joining",
                '${DateFormat('dd-MM-yyyy').format(document['joiningDate'].toDate())}'),
            buildKeyAndValueItem(
                "Salesman Code No", "${document['salesmanCode']}"),
            buildKeyAndValueItem(
                "Salesman Name", "${document['salesmanName']}"),
            buildKeyAndValueItem(
                "Salesman Mobile No", "${document['salesmanMobileNo']}"),
            buildKeyAndValueItem(
                "Applicant Name", "${document['applicantName']}"),
            buildKeyAndValueItem(
                "Father/Husband", "${document['fatherHusbandName']}"),
            buildKeyAndValueItem("Gender", "${document['gender']}"),
            buildKeyAndValueItem("Date of Birth",
                '${DateFormat('dd-MM-yyyy').format(document['dateOfBirth'].toDate())}'),
            buildKeyAndValueItem(
                "Marital Status", "${document['maritalStatus']}"),
            buildKeyAndValueItem("Address.", "${document['address']}"),
            buildKeyAndValueItem("Mobile No.", "${document['mobileNo']}"),
            buildKeyAndValueItem("Nominee Name", "${document['nomineeName']}"),
            buildKeyAndValueItem("Branch Code", "${document['branchCode']}"),
            buildKeyAndValueItem("Branch Name", "${document['branchName']}"),
            buildKeyAndValueItem(
                "Branch Manager", "${document['branchManager']}"),
            buildKeyAndValueItem("Slip", "${document['slip']}"),
            buildKeyAndValueItem("Amount", "${document['amount']}"),
          ],
        ),
      ),
    );

    return Scaffold(
      body: body,
      appBar: AppBar(
        leading: isAdmin
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                })
            : Container(),
        centerTitle: true,
        title: Text(
          "Member",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          !isAdmin
              ? IconButton(
                  icon: Icon(
                    // Icons.power_settings_new,
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
              : Container()
        ],
      ),
    );
  }
}
