import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';

class GetCatsUseCase {
  final CatRepository repository;

  GetCatsUseCase(this.repository);

  Future<List<Cat>> call() async {
    return await repository.getCats();
  }
}
