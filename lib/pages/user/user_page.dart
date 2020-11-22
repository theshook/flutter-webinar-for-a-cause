import 'package:flutter/material.dart';
import 'package:webinar_for_a_cause/api/user_api.dart';
import 'package:webinar_for_a_cause/models/user.dart';
import 'package:webinar_for_a_cause/widgets/rounded_input.dart';

class UserPage extends StatefulWidget {
  final Function(User) addNewUser;

  const UserPage({Key key, this.addNewUser}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final GlobalKey<FormState> _userForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  UserApi _userApi = UserApi();

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    super.dispose();
  }

  String validate(String val) {
    if (val.isEmpty) return 'This field is empty';
    return null;
  }

  void saveData() async {
    if (_userForm.currentState.validate()) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      try {
        User newUser = User(
          name: _name.text,
          username: _username.text,
          email: _email.text,
        );

        User createdUser = await _userApi.addUserData(newUser);
        widget.addNewUser(createdUser);
        Navigator.pop(context);
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Error: $e',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create new user'),
      ),
      body: Form(
        key: _userForm,
        child: Column(children: [
          RoundedInput(
            name: 'Name',
            controller: _name,
            validator: (val) => validate(val),
          ),
          RoundedInput(
            name: 'Username',
            controller: _username,
            validator: (val) => validate(val),
          ),
          RoundedInput(
            name: 'Email',
            controller: _email,
            validator: (val) => validate(val),
          ),
          ElevatedButton(
            onPressed: saveData,
            child: Text('Submit'),
          )
        ]),
      ),
    );
  }
}
