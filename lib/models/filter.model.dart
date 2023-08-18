class Filter {
  Map<String, dynamic> params;
  int? page;
  String? search;
  Filter({
    this.page,
    this.search,
    this.params = const {},
  });

  String get pageParam => page != null ? 'page=${page.toString()}' : '';
  String get searchParam => search != null ? 'search=$search' : '';

  String get urlParams {
    String p = '?$searchParam&$pageParam';
    if (params.isNotEmpty) {
      p += params.keys
          .where((k) => params[k] != null)
          .map((k) => '$k=${params[k]}')
          .join('&');
    }
    return p;
  }
}
