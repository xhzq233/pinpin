class SearchMockData {
  static List<String> getSearchResult() {
    final List<String> hints = [
      "search<em>111</em>",
      "hint<em>111</em>",
      "Dama<em>111</em>scus",
      "sea<em>111</em>rch",
      "hint",
      "Damascu<em>111</em>s",
      "search",
      "hint",
      "<em>111</em>Damascus"
    ];

    return hints;
  }
}