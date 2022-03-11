import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:moviehub/models/movieModel.dart';
import 'package:moviehub/widgets/movieCard.dart';

class DiscoverTv extends StatefulWidget {
  // final int pageNo = 1;
  const DiscoverTv({Key? key}) : super(key: key);

  @override
  _DiscoverTv createState() => _DiscoverTv();
}

class _DiscoverTv extends State<DiscoverTv> {
  List movies = [];
  int pageNo = 1;
  var url;
  final ScrollController _scrollController =  ScrollController();
  // var url = Uri.parse(
  //     "https://api.themoviedb.org/3/discover/movie?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US&sort_by=popularity.desc&page=1&with_watch_monetization_types=flatrate");
  final style = TextStyle(fontSize: 25, color: Colors.white);

  @override
  void initState() {
    super.initState();
    // var link2 = widget.link;
    // TODO: implement initState
    fetchData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        setState(() {

        });
        pageNo = pageNo+1;
        print(pageNo);
        fetchData();
      }
    });
  }

  Future fetchData() async {
    url = Uri.parse("https://api.themoviedb.org/3/discover/tv?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US&sort_by=popularity.desc&page=$pageNo&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0");
    var data = await http.get(url);
    Map<String, dynamic> jsonData = await jsonDecode(data.body);
    // print(jsonData["results"]);
    jsonData["results"].forEach((element) {
      // print(element["original_title"]);
      movies.add(
          Movie(
            type: 'tv',
              id: element["id"],
              title: (element["original_title"]==null)?element["name"]:element["original_title"],
              imageUrl:(element["backdrop_path"]==null)?"https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg" :"https://image.tmdb.org/t/p/original${element["backdrop_path"]}",
              // releaseDate: element["first_air_date"],
              releaseDate: (element["release_date"]==null)?element["first_air_date"]:element["release_date"],
              rateing: element["vote_average"])
      );
      print(movies);
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      color: Theme
          .of(context)
          .primaryColor,
      child: (movies.isEmpty) ? const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ):
      // RefreshIndicator(
      //    onRefresh: fetchData,
      //     color: Colors.red,
      //     backgroundColor: Theme.of(context).primaryColor,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children:movies
      //           .asMap()
      //           .entries.map((element) =>MovieCard(title: element.value.title,imageUrl: element.value.imageUrl,vote_average: element.value.rateing,release_date: element.value.releaseDate,)
      //          ).toList()
      //     ),
      //   ),
      // ));
      RefreshIndicator(
        onRefresh: fetchData,
        color: Colors.red,
        backgroundColor: Theme.of(context).primaryColor,
        child: ListView.builder(
            controller: _scrollController,
            // scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(
                type: 'tv',
                id: movies[index].id,
                  title: movies[index].title,
                  imageUrl: movies[index].imageUrl,
                  vote_average:  movies[index].rateing,
                  release_date:  movies[index].releaseDate);
            }),
      ),);
  }
}