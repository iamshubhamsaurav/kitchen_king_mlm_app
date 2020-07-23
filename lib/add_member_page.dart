import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Add Member",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: AddMemberForm(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class AddMemberForm extends StatefulWidget {
  @override
  AddMemberFormState createState() {
    return AddMemberFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddMemberFormState extends State<AddMemberForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _borderForAllFields =
      OutlineInputBorder(borderRadius: BorderRadius.circular(12.0));

  final _contentPaddingForAllFields =
      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

  final _spacingSizedBox = SizedBox(height: 12);

  DateTime _joiningDate;
  DateTime _dateOfBirth;

  var _genders = ['Male', 'Female', 'Others'];
  var _maritalStatus = ['Single', 'Married', 'Divorced', 'Widowed'];

  var _currentGenderSelected = 'Male';
  var _currentMaritalStatus = 'Single';

  void callJoiningDatePicker() async {
    var order = await getDate();
    setState(() {
      _joiningDate = order;
    });
  }

  void callDateOfBirthDatePicker() async {
    var order = await getDate();
    setState(() {
      _dateOfBirth = order;
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _spacingSizedBox,
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                onPressed: callJoiningDatePicker,
                color: Colors.blue,
                child: _joiningDate == null
                    ? Text('Select Joining Date',
                        style: TextStyle(color: Colors.white))
                    : Text(' ${DateFormat('yMd').format(_joiningDate)}',
                        style: TextStyle(color: Colors.white)),
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Salesman Code No.',
                labelText: "Salesman Code No.",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Salesman Name',
                labelText: "Salesman Name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Salesman Mobile No',
                labelText: "Salesman Mobile No",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Applicant name',
                labelText: "Applicant name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Father/Husband Name",
                labelText: "Father/Husband Name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            Row(
              children: <Widget>[
                Text('Select Gender'),
                SizedBox(width: 20),
                DropdownButton<String>(
                  items: _genders.map((String dropDownStringItem) {
                    return new DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: new Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      _currentGenderSelected = newValueSelected;
                    });
                  },
                  value: _currentGenderSelected,
                ),
              ],
            ),
            _spacingSizedBox,
            SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                onPressed: callDateOfBirthDatePicker,
                color: Colors.blue,
                child: _dateOfBirth == null
                    ? Text('Select Date of Birth',
                        style: TextStyle(color: Colors.white))
                    : Text(' ${DateFormat('yMd').format(_dateOfBirth)}',
                        style: TextStyle(color: Colors.white)),
              ),
            ),
            _spacingSizedBox,
            Row(
              children: <Widget>[
                Text('Marital Status'),
                SizedBox(width: 20),
                DropdownButton<String>(
                  items: _maritalStatus.map((String dropDownStringItem) {
                    return new DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: new Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      _currentMaritalStatus = newValueSelected;
                    });
                  },
                  value: _currentMaritalStatus,
                ),
              ],
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Address',
                labelText: "Address",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Mobile No',
                labelText: "Mobile No",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Nominee name',
                labelText: "Nominee name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Branch code',
                labelText: "Branch code",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Branch name',
                labelText: "Branch name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Branch manager',
                labelText: "Branch manager",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Slip',
                labelText: "Slip",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                labelText: "Amount",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: "Password",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {},
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                child: Text('SUBMIT', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
