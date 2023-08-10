abstract class Filter {
  int? page;
  String? search;
  Filter({
    this.page,
    this.search,
  });

  String get pageParam => page != null ? 'page=${page.toString()}' : '';
  String get searchParam => search != null ? 'search=$search' : '';
}
