import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviehub/screens/details.dart';

class MovieCard extends StatefulWidget {
  final String type;
  final int id;
  final String title;
  final String imageUrl;
  final dynamic vote_average;
  final String release_date;
  const MovieCard({Key? key,
    required this.type,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.vote_average,
    required this.release_date
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  final style = TextStyle(fontSize: 17,color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Details(id: widget.id,type: widget.type,)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0XFF1D252B)
        ),
        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
        padding: EdgeInsets.all(8),
        child:Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
                child: Image.network(widget.imageUrl,fit: BoxFit.cover,width: 80,height: 80,)),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )),
                    ),
                    Text("ReleaseDate : ${widget.release_date}",style:GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF707070)
                        )),),
                    Text("Rateing ⭐ : ${widget.vote_average}",style:GoogleFonts.nunito(
                    textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                        color: Color(0XFF4B98C4)
                    )),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
