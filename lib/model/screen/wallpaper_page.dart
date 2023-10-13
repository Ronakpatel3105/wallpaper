import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data_photo_model.dart';

class WallPaperPage extends StatefulWidget {
  const WallPaperPage({super.key});

  @override
  State<WallPaperPage> createState() => _WallPaperPageState();
}

class _WallPaperPageState extends State<WallPaperPage> {
  late Future<DataPhotoModel> photoDataModel;

  @override
  void initState() {
    super.initState();
    photoDataModel = getWallPaper("Fish");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WallPaper'),
      ),
      body: FutureBuilder<DataPhotoModel>(
        future: photoDataModel,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error:${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.photos!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 11,
                  childAspectRatio: 16/9,
                ),
                itemBuilder: (_, index) {
                  var eachWallPaper =
                      snapshot.data!.photos![index].src!.landscape!;
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        image: DecorationImage(
                          image: NetworkImage(eachWallPaper),
                          fit: BoxFit.fill,
                        )),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Future<DataPhotoModel> getWallPaper(String query) async {
    String url = "https://api.pexels.com/v1/search?query= $query&per_page=20";

    var res = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZm"
    });

    if (res.statusCode == 200) {
      var mData = jsonDecode(res.body);
      return DataPhotoModel.fromJson(mData);
    } else {
      return DataPhotoModel();
    }
  }
}
