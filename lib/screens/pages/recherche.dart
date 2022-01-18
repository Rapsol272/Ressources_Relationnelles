import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';



class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {

  bool _show = true;
  ExampleItemPager pager = ExampleItemPager();

    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: 
      SingleChildScrollView(
        child:
          /*AnimSearchBar(
        width: 400,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),*/
      Column(
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
                  return Future.delayed(const Duration(milliseconds: 1300), () {
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
      )
      );
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

