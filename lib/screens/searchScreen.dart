import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moviehub/models/movieModel.dart';
import 'package:moviehub/widgets/movieCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keyword ='';
  List<Movie> movies= [];
  var value = '' ;
  bool isSet =false ;
 final TextEditingController _keyword = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
 Future fetchQuery()async{
    movies = [];
    var url = Uri.parse("https://api.themoviedb.org/3/search/multi?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US&page=1&include_adult=true&query=$keyword");
    var data = await http.get(url);
    Map<String,dynamic> jsonData = jsonDecode(data.body);
    if(jsonData["results"]==[]){
      value = 'No results found';
      setState(() {

      });
      return;
    }
    print(jsonData["results"]);
    jsonData["results"].forEach((element)=>movies.add(
      Movie(type: element["media_type"], id: element["id"], title: (element.containsKey("original_name")||element.containsKey("original_title"))?(element["original_title"]==null)?element["original_name"]:element["original_title"]:'no title', imageUrl: (element["backdrop_path"]==null)?"https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg" :"https://image.tmdb.org/t/p/original${element["backdrop_path"]}",
          releaseDate:(element.containsKey("release_date")||element.containsKey("first_air_date"))? (element["release_date"]==null)?element["first_air_date"]:element["release_date"]:'no date', rateing: element["vote_average"])
    ));
    // print(movies);
    isSet=false;
   setState(() {
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                padding:const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: const Color(0XFF1D252B),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _keyword,
                        decoration:const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSet=true;
                          keyword = _keyword.text;
                        });
                        print(_keyword.text);
                        fetchQuery();
                      },
                      child: const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Icon(Icons.search_rounded,size: 30,color: Colors.red,),
                      ),
                    ),

                  ],
                ),
              ),
              (movies.isEmpty && isSet==false)?Expanded(
                  child: Text('Search the movie or tv show',style:GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                  ),)):const Text(''),
                (isSet)?
               const  Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                ):
                Expanded(
                  child:Container(
                    child: ListView.builder(
                      physics:const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      itemCount: movies.length,
                      itemBuilder: (context,index){
                        return MovieCard(
                            type: movies[index].type,
                            id: movies[index].id,
                            title: movies[index].title,
                            imageUrl: movies[index].imageUrl,
                            vote_average:  movies[index].rateing,
                            release_date:  movies[index].releaseDate);
                      }),
                  ),
                )
            ],
          ),
        ),
    );
  }
}
