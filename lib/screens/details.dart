import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:moviehub/models/detailsModel.dart';

class Details extends StatefulWidget {
  final int id;
  final String type;

  const Details({Key? key,required this.id,required this.type}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var de;
  var data;
  var fit = BoxFit.cover;
  List<String> categories =[];
  final style = TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetchDetails();
  }
  
  fetchDetails()async{
    var url = Uri.parse("https://api.themoviedb.org/3/${widget.type}/${widget
        .id}?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US");
    var res = await http.get(url);
    Map<String, dynamic> jsonData = await jsonDecode(res.body);
      // data = jsonDecode(res.body);
    jsonData["genres"].forEach((element)=>{
    categories.add(element["name"])
    });
   de = DetailsModel(title:(jsonData["original_title"]==null)?jsonData["original_name"]:jsonData["original_title"],imageUrl: (jsonData["backdrop_path"]==null)?"https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg":'https://image.tmdb.org/t/p/original/${jsonData["poster_path"]}',desc:jsonData["overview"],category: categories );
   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text('MovieHub',
            style:GoogleFonts.nunito(
                textStyle: style
            ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: (de==null)?const Center(
          child:  CircularProgressIndicator(
            color: Colors.red,
          ),
        ):Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(de.imageUrl,fit: fit,height: 400,width:  MediaQuery.of(context).size.width,)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          (fit==BoxFit.cover)?fit = BoxFit.contain:fit=BoxFit.cover;
                        });
                      },
                      child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      width:MediaQuery.of(context).size.width ,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(de.title,style: GoogleFonts.nunito(
                            textStyle:const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22
                            )
                        ),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 15,bottom: 10,top: 10),
                  child: Text('Category',style: GoogleFonts.nunito(
                      textStyle:const TextStyle(
                          color: Color(0XFF4B98C4),
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      )
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: categories
                          .asMap()
                          .entries
                          .map((e) =>
                          Container(
                            margin: EdgeInsets.only(left: 8,right: 8),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Color(0XFF1D252B),
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text(e.value,style: GoogleFonts.nunito(
                                textStyle:const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ))),
                      )).toList()
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,bottom: 10),
                  child: Text('Description',style: GoogleFonts.nunito(
                      textStyle:const TextStyle(
                          color: Color(0XFF4B98C4),
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      )
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15),
                  child: Text(de.desc,style: GoogleFonts.nunito(
                      textStyle:const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ))),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
