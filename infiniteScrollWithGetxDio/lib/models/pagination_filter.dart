class PaginationFilter {
  int page;
  int limit;

  ///É necessário este equality para identificar se 
  ///o objeto foi alterado, pois usaremos isso dentro do
  ///getX para tornar esta classe observável
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaginationFilter &&
      other.page == page &&
      other.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;

  @override
  String toString() => 'PaginationFilter(page: $page, limit: $limit)';
}
