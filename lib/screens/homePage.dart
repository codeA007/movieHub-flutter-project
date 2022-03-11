import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviehub/screens/discover.dart';
import 'package:moviehub/screens/linkFetcher.dart';
import 'package:moviehub/screens/searchScreen.dart';
import 'package:moviehub/screens/trending.dart';
import 'package:moviehub/widgets/movieTabBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final TabController _tabController = TabController(length: 2,vsync:this);
  final style = TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold);
  final tabTextStyle = TextStyle(fontSize: 22,fontWeight: FontWeight.bold);
  int selectedIndex =0;
  final screens = [
    Discover(),
    Trending(),
    SearchScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text('MovieHub',
            style:GoogleFonts.nunito(
              textStyle: style
            )
          ),
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(50),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Container(
          //       width: double.maxFinite,
          //       padding: const EdgeInsets.only(top: 15,bottom: 15),
          //       color: Color(0XFF11191F),
          //       child: TabBar(
          //         indicatorColor:Colors.transparent ,
          //         labelColor: Colors.red,
          //         unselectedLabelColor: Color(0XFF707070),
          //         labelPadding: EdgeInsets.only(left: 20,right: 20),
          //         isScrollable: true,
          //         tabs: [
          //           Text('Movies', style: GoogleFonts.nunito(
          //               textStyle: tabTextStyle
          //           ) ),
          //           Text('Tv Shows', style: GoogleFonts.nunito(
          //               textStyle: tabTextStyle
          //           ))
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: screens[selectedIndex],
        // SafeArea(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         SizedBox(
        //           height: MediaQuery.of(context).size.height,
        //           width: double.maxFinite,
        //           child: TabBarView(children: [
        //            Trending(),
        //             Text('trending movies'),
        //           ]),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Color(0XFF1D252B),
          onTap: (value){
            setState(() {
              selectedIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Color(0XFF707070),
          selectedFontSize: 0,
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.explore_rounded,size: 30,),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.whatshot_rounded,size: 30,),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded,size: 30,),label: ''),
            // BottomNavigationBarItem(icon: Icon(Icons.person_rounded,size: 30,),label: ''),
          ],
        ),
      ),
    );
  }
}
