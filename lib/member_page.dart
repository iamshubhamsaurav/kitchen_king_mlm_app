import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  final bool isAdmin;
  MemberPage({Key key, @required this.isAdmin}) : super(key: key);

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
            buildKeyAndValueItem("Date of Joining", '10/7/2020'),
            buildKeyAndValueItem("Salesman Code No", "89802"),
            buildKeyAndValueItem("Salesman Name", "Mr Salesman"),
            buildKeyAndValueItem("Application Name", "Ram Kumar"),
            buildKeyAndValueItem("Father/Husband", "Mr Father "),
            buildKeyAndValueItem("Gender", "Male"),
            buildKeyAndValueItem("Date of Birth", "02/01/1996"),
            buildKeyAndValueItem("Matital Status", "Single"),
            buildKeyAndValueItem("Address.",
                "Temp Address Which is very long to check the text overflow. And the text should work on multiline level"),
            buildKeyAndValueItem("Mobile No.", "8980200000"),
            buildKeyAndValueItem("Nominee Name", "Mr Kushal Ranjan Prasad"),
            buildKeyAndValueItem("Branch Code", "014"),
            buildKeyAndValueItem("Branch Name", "CP, Delhi"),
            buildKeyAndValueItem("Branch Manager", "Mr Lakshman"),
            buildKeyAndValueItem("Slip", "----"),
            buildKeyAndValueItem("Amount", "500.0"),
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
