import 'package:flutter/material.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //标题栏
        appBar: AppBar(
          title: const Text("DECO3801Narhwals"),
        ),
        //内容区域
        body: HomeContent(),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      //给Drawer加上头布局
                      child: UserAccountsDrawerHeader(
                    //头像
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://profile.csdnimg.cn/B/3/3/1_m0_38013946"),
                    ),
                    accountName: Text("account name"),
                    accountEmail: Text("xxxxxx.gmail.com"),
                  ))
                ],
              ),
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.title, color: Color.fromARGB(255, 153, 230, 11)),
                ),
                title: Text("Title Screen"),
                trailing: Icon(Icons.chevron_right),
              ),
              //分割线
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.home, color: Colors.yellow),
                ),
                title: Text("Main Idle Screen"),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.settings, color: Colors.purple),
                ),
                title: Text("Setting Page"),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.play_arrow, color: Colors.red),
                ),
                title: Text("Minigame selection screen"),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.games_sharp, color: Colors.blue),
                ),
                title: Text("Gyro Minigame"),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      //主题
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
 
class HomeContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
    );
  }
}