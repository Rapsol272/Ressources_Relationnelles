import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'dart:async';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isPressed = false;
  var isLiked = Icon(
    Icons.favorite,
    color: Colors.red,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 1), (x) => refreshNum);

  @override
  Widget build(BuildContext context) {
    ExampleItemPager pager = ExampleItemPager();

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff03989E), Color(0xffF9E79F)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 600,
                  child: PaginatedSearchBar<ExampleItem>(
                    maxHeight: 200,
                    hintText: 'Tapez votre recherche ici ...',
                    emptyBuilder: (context) {
                      return const Text("I'm an empty state!");
                    },
                    placeholderBuilder: (context) {
                      return const Text("");
                    },
                    paginationDelegate: EndlessPaginationDelegate(
                      pageSize: 20,
                      maxPages: 3,
                    ),
                    onSearch: ({
                      required pageIndex,
                      required pageSize,
                      required searchQuery,
                    }) async {
                      return Future.delayed(const Duration(milliseconds: 1300),
                          () {
                        if (searchQuery == "empty") {
                          return [];
                        }

                        if (pageIndex == 0) {
                          pager = ExampleItemPager();
                        }

                        return pager.nextBatch();
                      });
                    },
                    itemBuilder: (
                      context, {
                      required item,
                      required index,
                    }) {
                      return Text(item.title);
                    },
                  ),
                ),
              ),
            ],
          ),

          /*Center(
        child: TextField(
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white24,
            border: UnderlineInputBorder(
            ),
            label: Text('Rechercher', style: TextStyle(color: greenMajor),),
          ),
          onTap: () {
            showSearch(context: context, delegate:CustomSearchDelegate());
          },
        )
      )*/
          /*StreamBuilder<int>(
            stream: counterStream,
            builder: (context, snapshot) {
              return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
            return Container(
            );
            }).toList(),
          );
        },);
            })*/
        ));
  }
}

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  List<ExampleItem> nextBatch() {
    List<ExampleItem> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(ExampleItem(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;

    return batch;
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Adrien',
    'Anthony',
    'Loic',
    'Baptiste',
    'Antoine',
    'Mendy'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var user in searchTerms) {
      if (user.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
