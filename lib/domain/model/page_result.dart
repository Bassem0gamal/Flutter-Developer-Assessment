
class PageResult<T> {
  final List<T> items;
  final int pageNum;
  final int totalItems;

  PageResult({
    required this.items,
    required this.pageNum,
    required this.totalItems,
  });

  isLastPage(int pageSize) {
    return (pageNum + 1) * pageSize >= totalItems;
  }
}