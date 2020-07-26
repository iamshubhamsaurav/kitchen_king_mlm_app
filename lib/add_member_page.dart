import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';

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

class AddMemberFormState extends State<AddMemberForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitButtonEnabled = true;

  final _borderForAllFields =
      OutlineInputBorder(borderRadius: BorderRadius.circular(12.0));

  final _contentPaddingForAllFields =
      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

  final _spacingSizedBox = SizedBox(height: 12);

  DateTime _joiningDate = DateTime.now();
  DateTime _dateOfBirth = DateTime(2000);

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

  // All the fields Controller
  final _salesmanCodeFieldController = TextEditingController();
  final _salesmanNameFieldController = TextEditingController();
  final _salesmanMobileNoFieldController = TextEditingController();
  final _applicantNameFieldController = TextEditingController();
  final _fatherHusbandNameFieldController = TextEditingController();
  final _addressFieldController = TextEditingController();
  final _mobileNoFieldController = TextEditingController();
  final _nomineeNameFieldController = TextEditingController();
  final _branchCodeFieldController = TextEditingController();
  final _branchNameFieldController = TextEditingController();
  final _branchManagerFieldController = TextEditingController();
  final _slipFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  void setFieldsToDefaults() {
    //DateFields to Defaults
    _joiningDate = DateTime.now();
    _dateOfBirth = DateTime.now();
    // DropDown To Default
    _currentGenderSelected = "Male";
    _currentMaritalStatus = "Single";
    // TextFormField To Default Value
    _salesmanCodeFieldController.text = "";
    _salesmanNameFieldController.text = "";
    _salesmanMobileNoFieldController.text = "";
    _applicantNameFieldController.text = "";
    _fatherHusbandNameFieldController.text = "";
    _addressFieldController.text = "";
    _mobileNoFieldController.text = "";
    _nomineeNameFieldController.text = "";
    _branchCodeFieldController.text = "";
    _branchNameFieldController.text = "";
    _branchManagerFieldController.text = "";
    _slipFieldController.text = "";
    _amountFieldController.text = "";
    _passwordFieldController.text = "";
  }

  // Firestore Refrence
  final databaseReference = Firestore.instance;

  String _createId(int count) {
    count++;
    var id = count.toString().padLeft(4, "0");
    return "kk" + id;
  }

  void _registerMember() async {
    setState(() {
      _isSubmitButtonEnabled = false;
    });

    await databaseReference
        .collection("members")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      // snapshot.documents.forEach((f) => print('${f.data}}'));
      // print("&&&&&&&&");
      // print(snapshot.documents.toList().length);
      // totalMembers = snapshot.documents.toList().length;
      // print("##########$totalMembers");
      // Add the registraion code here...
      var id = _createId(snapshot.documents.toList().length);
      var password = _passwordFieldController.text;
      var name = _applicantNameFieldController.text;
      var salesmanCode = _salesmanCodeFieldController.text;

      var mobileNumbers = [
        _mobileNoFieldController.text,
        _salesmanMobileNoFieldController.text
      ];

      databaseReference.collection("members").document(id).setData({
        'id': id,
        'joiningDate': _joiningDate,
        'salesmanCode': _salesmanCodeFieldController.text.toLowerCase(),
        'salesmanName': _salesmanNameFieldController.text,
        'salesmanMobileNo': _salesmanMobileNoFieldController.text,
        'applicantName': _applicantNameFieldController.text,
        'fatherHusbandName': _fatherHusbandNameFieldController.text,
        'gender': _currentGenderSelected,
        'dateOfBirth': _dateOfBirth,
        'maritalStatus': _currentMaritalStatus,
        'address': _addressFieldController.text,
        'mobileNo': _mobileNoFieldController.text,
        'nomineeName': _nomineeNameFieldController.text,
        'branchCode': _branchCodeFieldController.text,
        'branchName': _branchNameFieldController.text,
        'branchManager': _branchManagerFieldController.text,
        'slip': _slipFieldController.text,
        'amount': _amountFieldController.text,
        'password': _passwordFieldController.text,
      }).whenComplete(() => {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    elevation: 20,
                    title: Text("Registration Successful"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _sendSMS(id, password, name, salesmanCode,
                                mobileNumbers);
                          },
                          child: Text('OK',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18)))
                    ],
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Member Id: $id"),
                          SizedBox(height: 10),
                          Text("Password: $password"),
                          SizedBox(height: 10),
                          Text("Name: $name"),
                        ]),
                  );
                }),
            setFieldsToDefaults(),
            setState(() {
              _isSubmitButtonEnabled = true;
            }),
          });
    });
  }

  void _sendSMS(String memberId, String password, String applicantName,
      String salesmanCode, List<String> recipents) async {
    var message =
        "Kitchen King\nMember Registered.\nID:$memberId\nName:$applicantName\nPassword:$password\nSalesmanCode:$salesmanCode";
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void _submitRegistrationForm() {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _registerMember();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Registering Member'),
        duration: Duration(seconds: 3),
      ));
    }
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
            Text("Select Joining Date:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                onPressed: callJoiningDatePicker,
                color: Colors.blue,
                child: _joiningDate == null
                    ? Text('Select Joining Date',
                        style: TextStyle(color: Colors.white))
                    : Text(' ${DateFormat('dd-MM-yyyy').format(_joiningDate)}',
                        style: TextStyle(color: Colors.white)),
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              validator: (value) {
                if (value.length != 6 ||
                    !value.startsWith("kk") ||
                    value.contains(" ")) {
                  return 'Enter valid salesman code';
                }
                return null;
              },
              controller: _salesmanCodeFieldController,
              decoration: InputDecoration(
                hintText: 'Salesman Code No.',
                labelText: "Salesman Code No.",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              controller: _salesmanNameFieldController,
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
              validator: (value) {
                if (value.length < 10) {
                  return 'Invalid Mobile No.';
                }
                return null;
              },
              controller: _salesmanMobileNoFieldController,
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter applicant name';
                }
                return null;
              },
              controller: _applicantNameFieldController,
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
              controller: _fatherHusbandNameFieldController,
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
            Text("Select Joining Date:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                onPressed: callDateOfBirthDatePicker,
                color: Colors.blue,
                child: _dateOfBirth == null
                    ? Text('Select Date of Birth',
                        style: TextStyle(color: Colors.white))
                    : Text(' ${DateFormat('dd-MM-yyyy').format(_dateOfBirth)}',
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
              controller: _addressFieldController,
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
              validator: (value) {
                if (value.length < 10) {
                  return 'Invalid Mobile No.';
                }
                return null;
              },
              controller: _mobileNoFieldController,
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
              controller: _nomineeNameFieldController,
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
              controller: _branchCodeFieldController,
              decoration: InputDecoration(
                hintText: 'Branch code',
                labelText: "Branch code",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              controller: _branchNameFieldController,
              decoration: InputDecoration(
                hintText: 'Branch name',
                labelText: "Branch name",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              controller: _branchManagerFieldController,
              decoration: InputDecoration(
                hintText: 'Branch manager',
                labelText: "Branch manager",
                contentPadding: _contentPaddingForAllFields,
                border: _borderForAllFields,
              ),
            ),
            _spacingSizedBox,
            TextFormField(
              controller: _slipFieldController,
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
              controller: _amountFieldController,
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
              validator: (value) {
                if (value.length < 4) {
                  return 'Password should be min 4 char';
                }
                return null;
              },
              controller: _passwordFieldController,
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
                // onPressed: _isSubmitButtonEnabled ? _registerMember : null,
                onPressed:
                    _isSubmitButtonEnabled ? _submitRegistrationForm : null,
                padding: EdgeInsets.all(12),
                color: _isSubmitButtonEnabled ? Colors.blue : Colors.blueGrey,
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
