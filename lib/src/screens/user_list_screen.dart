import 'package:flutter/material.dart';
import 'package:weather_app/src/models/user_data_model.dart';
import 'package:weather_app/src/services/user_data.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool isSwitch = false;
  List<User>? users;
  onLogoutPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text('Are you sure want to Logout?'),
        content: const Text('You want to login after you logot from the page'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 203, 16, 3)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/welcome"),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    UserDataHelper userDataHelper = UserDataHelper();
    users = await userDataHelper.getUsers();
    setState(() {});
  }

  Future<void> deleteUser(int userId) async {
    UserDataHelper userDataHelper = UserDataHelper();
    await userDataHelper.deleteUser(userId);
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: onLogoutPressed,
        ),
        foregroundColor: Colors.blueGrey,
        title: const Text("User List"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/form');
                },
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchUsers,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: users?.length,
                itemBuilder: (context, index) {
                  // var isSelected;
                  return Dismissible(
                    key: Key(users?[index].id.toString() ?? index.toString()),
                    onDismissed: (dirextion) {
                      deleteUser(users![index].id!);
                    },
                    background: Container(
                      color: const Color.fromARGB(255, 243, 33, 33),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 14.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(236, 199, 199, 199),
                                  offset: Offset(1, 2),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/weather');
                          },
                          textColor: const Color.fromARGB(255, 255, 255, 255),
                          title: Text(
                              "${users?[index].firstName} ${users?[index].lastName}"),
                          subtitle: Text("${users?[index].email}"),
                          // trailing: Switch(
                          //     value: isSwitch,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         isSwitch = value;
                          //       });
                          //     })
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
