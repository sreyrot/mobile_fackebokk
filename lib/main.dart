
import 'package:flutter/material.dart';

// tack from api
import 'dart:async';
// convert api
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(FackeBook());

class FackeBook extends StatefulWidget {
  @override
  _FackeBookState createState() => _FackeBookState();
}

class _FackeBookState extends State<FackeBook> {
   Map users;
   List userDate;
  // function to get data
  Future getUser() async{
    http.Response response= await http.get("https://reqres.in/api/users");
  debugPrint(response.body);
users= json.decode(response.body);
setState(() {

  // user data
  userDate = users['data'];
});
debugPrint(userDate.toString());

  }
// to call function need to var state
@override
  void initState() {
    
    super.initState();
    getUser();
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mobile FackeBook'),
          backgroundColor:  Colors.pink[900],
        ),

        // build listview by your self
        body: ListView.builder(

          // depend on listview if userdate null display =0 else display userDate.length
          itemCount: userDate == null ? 0 : userDate.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  // ctr + . on CircleAvatar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(userDate[index]['avatar'],
                      fit: BoxFit.cover,
                      height: 400.0,
                      width: 400.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(userDate[index]['avatar']),
                          
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${userDate[index]['first_name']}, ${userDate[index]['last_name']}", 
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue[900],
                      ),
                      
                    ),
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_up, color: Colors.green,),
                          onPressed: () {},
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.thumb_down, color: Colors.blue,),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share, color: Colors.red,),
                        ),
                      ],
                    )
                    
                  ),
                ],
              ),
            );
          },
        ),
        
      ),
    );
  }
}