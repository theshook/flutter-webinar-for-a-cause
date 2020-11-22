import 'package:flutter/material.dart';
import 'package:webinar_for_a_cause/api/user_api.dart';
import 'package:webinar_for_a_cause/models/user.dart';
import 'package:webinar_for_a_cause/pages/user/user_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserApi _userApi = UserApi();
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    List<User> userResponse = await _userApi.getUsersData();
    setState(() => users = userResponse);
  }

  Future<void> deleteUser(int id, int idx) async {
    await _userApi.deleteUserData(id);
    setState(() => users.removeAt(idx));
  }

  void addNewUserToList(User user) => setState(() => users.add(user));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: users.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int idx) {
                return Dismissible(
                  key: ValueKey(users[idx].id),
                  onDismissed: (dismissed) {
                    try {
                      deleteUser(users[idx].id, idx);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[idx].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(users[idx].username),
                        Text(users[idx].email),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => UserPage(
              addNewUser: addNewUserToList,
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
