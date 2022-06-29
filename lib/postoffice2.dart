import 'dart:convert';
import 'find_postOffice_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post_Office_2 extends StatefulWidget {
  Post_Office_2({Key? key}) : super(key: key);

  @override
  State<Post_Office_2> createState() => _Post_Office_2State();
}

class _Post_Office_2State extends State<Post_Office_2> {
  List<PostOffice> postList = [];

  Future<List<PostOffice>> getPostOffice() async {
    String url = "https://api.postalpincode.in/pincode/110081";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i['name']);
        postList.add(PostOffice.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostOffice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPostOffice(),
          builder: (context, AsyncSnapshot<List<PostOffice>> snapshot) {
            if (snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postList[index].block.toString(),
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          postList[index].branchType.toString(),
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ));
                  });
            }
          }),
    );
  }
}
