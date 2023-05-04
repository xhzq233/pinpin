import 'dart:core';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class SearchHighlightEntity {
  final String text;
  final bool highlight;

  const SearchHighlightEntity({
    required this.text,
    required this.highlight,
  });

  static List<SearchHighlightEntity> parseSearchResult(String result) {
    var document = parse(result);
    var nodes = document.body?.nodes;
    if (nodes != null) {
      return _parseNodes(nodes);
    } else {
      return [];
    }
  }

  static List<SearchHighlightEntity> _parseNodes(NodeList nodes) {
    var result = <SearchHighlightEntity>[];
    nodes.forEach((element) {
      switch (element.nodeType) {
        case Node.TEXT_NODE:
          result.add(
            SearchHighlightEntity(
              text: element.text ?? "",
              highlight: false,
            ),
          );
          break;
        case Node.ELEMENT_NODE:
          var e = element as Element;
          if (e.localName == 'em') {
            e.nodes.forEach((element) {
              switch (element.nodeType) {
                case Node.TEXT_NODE:
                  result.add(
                    SearchHighlightEntity(
                      text: element.text ?? "",
                      highlight: true,
                    ),
                  );
                  break;
                default:
                  break;
              }
            });
          }
          break;
        default:
          break;
      }
    });

    return result;
  }
}