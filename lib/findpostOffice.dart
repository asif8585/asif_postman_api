import 'dart:convert';
import 'find_postOffice_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Find_Post_Office extends StatefulWidget {
  Find_Post_Office({Key? key}) : super(key: key);

  @override
  State<Find_Post_Office> createState() => _Find_Post_OfficeState();
}

class _Find_Post_OfficeState extends State<Find_Post_Office> {
  List<PostModal> postList = [];

  Future<List<PostModal>> getPostOffice() async {
    String url = "https://api.postalpincode.in/pincode/110081";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i['name']);
        postList.add(PostModal.fromJson(i));
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
          builder: (context, AsyncSnapshot<List<PostModal>> snapshot) {
            if (!snapshot.hasData) {
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
                          postList[index].message.toString(),
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          postList[index].postOffice.toString(),
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
