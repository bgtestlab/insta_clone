import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Insta Clone',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              'Welcome to Insta Clone!',
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text('사진과 영상을 보려면 팔로우 하세요'),
            Padding(padding: EdgeInsets.all(8.0)),
            SizedBox(
              width: 260.0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_user.photoURL!),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                        _user.email!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                      ),
                      Text(_user.displayName!),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2022/09/13/17/02/leaves-7452420_960_720.jpg',
                                fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                          Center(
                            child: SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2022/03/31/11/28/snakes-head-fritillary-7102810_960_720.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                          ),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2022/09/10/15/13/sky-7445243_960_720.jpg',
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text('Facebook 친구'),
                      ElevatedButton(
                        child: Text('Follow'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )))));
  }
}
