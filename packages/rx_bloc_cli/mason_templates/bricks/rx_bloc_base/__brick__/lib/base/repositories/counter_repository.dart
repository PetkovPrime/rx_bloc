{{> licence.dart }}

import '../common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/remote/count_remote_data_source.dart';
import '../models/count.dart';

// Decouple Data Layer and Business Logic Layer
class CounterRepository {
  CounterRepository(this._errorMapper, this._countRemoteDataSource);

  final ErrorMapper _errorMapper;
  final CountRemoteDataSource _countRemoteDataSource;

  /// Fetch current value of the counter
  Future<Count> getCurrent() =>
      _errorMapper.execute(() => _countRemoteDataSource.getCurrent());

  /// Fetch incremented value of the counter
  Future<Count> increment() =>
      _errorMapper.execute(() => _countRemoteDataSource.increment());

  /// Fetch decremented value of the counter
  Future<Count> decrement() =>
      _errorMapper.execute(() => _countRemoteDataSource.decrement());
}
