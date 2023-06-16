import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/batch_local_repository.dart';
import '../entity/batch_entity.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref) {
  // return local repo implementation
  // for internet connectivity we will check later
  return ref.read(batchLocalRepoProvider);
});

// interface class
abstract class IBatchRepository {
  // abstract method for getting all batches
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();

  // abbstract method for adding batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
}
