import '../entities/cat.dart';

abstract class CatRepository {
  Future<List<Cat>> getCats({int limit = 10, int page = 0});
}
