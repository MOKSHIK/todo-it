// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/cacheservice.dart';
import 'package:todo_list/services/todoservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoController = TextEditingController();
  bool _isTicked = false;
  Color getColor(Set<MaterialState> states) {
    return ConstantColors.accentColor;
  }

  late String name;
  List<dynamic> todos = [];
  bool _loading = true;

  userInfo() async {
    var data = await TodoServices.getUserName();
    var todosObj = await TodoServices.getUserTodo();
    todos = todosObj['data'];
    name = data['name'];
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    userInfo();
    super.initState();
  }

  CacheService cacheService = CacheService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await cacheService.deleteCache(key: "jwt");
                  await cacheService.deleteCache(key: "id");
                  Navigator.of(context).popAndPushNamed(loginPage);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 500),
                    backgroundColor: ConstantColors.accentColor,
                    content: const Text('Hope to see you back soon!'),
                  ));
                },
                icon: Icon(Icons.logout_outlined))
          ],
          backgroundColor: ConstantColors.box,
          centerTitle: false,
          title: Row(
            children: [
              Text(
                "TO",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "DO-IT",
                style: TextStyle(
                    color: ConstantColors.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: ConstantColors.accentColor,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.only(left: 20),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Text(
                          name[0].toUpperCase(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: ConstantColors.accentColor),
                        ),
                        Text(
                          name.substring(1),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: ConstantColors.accentColor),
                        ),
                        Text(
                          "'s todo's",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                todos.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Center(
                          child: Text(
                            "All task's completed.",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: todos.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: ConstantColors.box,
                                        child: ListTile(
                                          trailing: IconButton(
                                            color: Colors.red,
                                            icon: Icon(Icons.delete_outlined),
                                            onPressed: () async {
                                              var message = await TodoServices
                                                  .deleteUserTodo(
                                                      todos[index]['_id']);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                backgroundColor:
                                                    ConstantColors.accentColor,
                                                content:
                                                    Text(message['message']),
                                              ));
                                              setState(() {
                                                todos.removeAt(index);
                                              });
                                            },
                                          ),
                                          title: Text(
                                            todos[index]['task'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        foregroundColor: Colors.white,
        backgroundColor: ConstantColors.accentColor,
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: ConstantColors.box,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 15.0,
                          right: 15.0,
                          top: 15.0),
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          hintText: "ex - Clean Air Joradn's 1.",
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: FloatingActionButton(
                        backgroundColor: ConstantColors.accentColor,
                        child: Icon(Icons.done),
                        onPressed: () async {
                          var response = await TodoServices.addUserTodo(
                              todoController.text);
                          setState(() {
                            todos.add({
                              // "user": "62a0770d0368c11b30814bcd",
                              "task": response['data']['task'],
                              "_id": response['data']['_id']
                            });
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 500),
                            backgroundColor: ConstantColors.accentColor,
                            content: Text(response['message']),
                          ));
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
