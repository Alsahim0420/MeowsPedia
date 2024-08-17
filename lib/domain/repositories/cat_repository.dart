import '../entities/cat.dart';

abstract class CatRepository {
  Future<List<Cat>> getCats();
}
