import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviehub/screens/discoverTv.dart';
import 'package:moviehub/screens/linkFetcher.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    // final style = TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold);
    final style = TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold);
    const tabTextStyle =  TextStyle(fontSize: 22,fontWeight: FontWeight.bold);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          bottom:PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(bottom: 12),
                color: Color(0XFF11191F),
                child: TabBar(
                  indicatorColor:Colors.transparent ,
                  labelColor: Colors.red,
                  unselectedLabelColor: Color(0XFF707070),
                  labelPadding: EdgeInsets.only(left: 20,right: 20),
                  isScrollable: true,
                  tabs: [
                    Text('Movies', style: GoogleFonts.nunito(
                        textStyle: tabTextStyle
                    ) ),
                    Text('Tv Shows', style: GoogleFonts.nunito(
                        textStyle: tabTextStyle
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            LinkFetcher(),
            DiscoverTv()
            // LinkFetcher(link:"https://api.themoviedb.org/3/discover/movie?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US&sort_by=popularity.desc&page=1&with_watch_monetization_types=flatrate"),
            // LinkFetcher(link: "https://api.themoviedb.org/3/discover/tv?api_key=a78dda2b97306a1f556293bf49c50851&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0")
          ],
        )
      ),
    );
  }
}
