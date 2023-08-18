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
    var p =
        <String>[searchParam, pageParam].where((e) => e.isNotEmpty).toList();

    String queryParams = '';
    if (params.isNotEmpty) {
      p += params.keys
          .where((k) => params[k] != null)
          .map((k) => '$k=${params[k]}')
          .toList();
      queryParams += p.join('&');
    }
    if (queryParams.isNotEmpty) return '?$queryParams';
    return '';
  }
}
