import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/batch_entity.dart';
import '../model/batch_hive_model.dart';

// injecting hiveService and batchHiveModel in BatchLocalDataSource
// ref is used to read from another Provider to Provider

final batchLocalDataSourceProvider = Provider<BatchLocalDataSource>((ref) {
  return BatchLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    batchHiveModel: ref.read(batchHiveModelProvider),
  );
});

class BatchLocalDataSource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel,
  });

  // add batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      // convert Entity to Hive Object
      final hiveBatch = batchHiveModel.toHiveModel(batch);

      // add to hive
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // get all batches
// NOte: this is conversion
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      // get all batches from Hive
      final batches = await hiveService.getAllBatches();
      // convert Hive object to Entity
      final batchEntities = batchHiveModel.toEntityList(batches);
      return Right(batchEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
