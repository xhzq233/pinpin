import 'package:flutter/material.dart';
import 'package:pinpin/page/search/search_hint/controller.dart';
import 'package:pinpin/page/search/search_hint/model/mock_data.dart';
import 'package:pinpin/page/search/search_hint/model/search_hint_highlight_entity.dart';
import 'package:pinpin/page/search/search_hint/search_hint_item.dart';

class SearchHintPage extends StatelessWidget {
  const SearchHintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SearchHintController();

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ListView.builder(
          itemCount: SearchMockData.getSearchResult().length,
          itemBuilder: (context, index) => SearchHintItem(
                onTap: () {
                  controller.handleSearchPinPin(SearchMockData.getSearchResult()[index]);
                },
                hint: SearchHighlightEntity.parseSearchResult(SearchMockData.getSearchResult()[index]),
              )),
    );
  }
}
