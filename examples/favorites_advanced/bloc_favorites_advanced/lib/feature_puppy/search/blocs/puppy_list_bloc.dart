import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:favorites_advanced_base/models.dart';
import 'package:favorites_advanced_base/repositories.dart';
import 'package:meta/meta.dart';

part 'puppy_list_event.dart';

part 'puppy_list_state.dart';

// part 'puppy_list_bloc_models.dart';

class PuppyListBloc extends Bloc<PuppyListEvent, PuppyListState> {
  PuppyListBloc(this.repository)
      : super(const PuppyListState(status: PuppyListStatus.loading));

  PuppiesRepository repository;
  List<Puppy> puppyItems = [];

  Future<List<Puppy>> _fetchPuppies(PuppiesRepository repository) async {
    var puppies = <Puppy>[];
    puppies = await repository.getPuppies(query: '');
    if (puppies.isEmpty) {
      throw Exception('error fetching puppies');
    }
    return puppies;
  }

  @override
  Stream<PuppyListState> mapEventToState(
    PuppyListEvent event,
  ) async* {
    if (event is LoadPuppyListEvent) {
      yield await _mapPuppiesFetchedToState(state);
    } else if (event is ReloadPuppiesEvent) {
      yield* _mapPuppiesReloadFetchToState(state);
    } else if (event is PuppyFetchDetailsEvent) {
      yield* _mapPuppyDetailFetchedToState(event, state);
    }
  }

  Stream<PuppyListState> _mapPuppyDetailFetchedToState(
      PuppyFetchDetailsEvent event, PuppyListState state) async* {
    final puppyWithDetails =
        await repository.fetchPuppyExtraDetails(puppy: event.puppy);
    // print('puppy id: ${puppyWithDetails.id}');
    // print('puppy displayName: ${puppyWithDetails.displayName}');
    // print(
    //     'puppy displayCharacteristics: ${
    //         puppyWithDetails.displayCharacteristics}');

    await repository.updatePuppy(puppyWithDetails.id, puppyWithDetails);

    yield PuppyListState.extraDetailsLoadSuccess(
      searchedPuppies: puppyItems,
      status: PuppyListStatus.success,
    );
  }

  Stream<PuppyListState> _mapPuppiesReloadFetchToState(
      PuppyListState state) async* {
    // final puppyItemsNew = ;
    puppyItems = <Puppy>[];

    yield PuppyListState.reloadInProgress(
        searchedPuppies: puppyItems, status: PuppyListStatus.success);
    // await Future.delayed(const Duration(milliseconds: 3000));
    // await repository.setDisplayNameAndDisplayCharacteristicsToNull();

    puppyItems = await _fetchPuppies(repository);
    yield PuppyListState.reloadInProgress(
        searchedPuppies: puppyItems, status: PuppyListStatus.success);
  }

  Future<PuppyListState> _mapPuppiesFetchedToState(PuppyListState state) async {
    try {
      if (state.status == PuppyListStatus.loading) {
        // await Future.delayed(const Duration(milliseconds: 300));
        // When puppies are loaded for the first time
        puppyItems = await _fetchPuppies(repository);
        return state.copyWith(
          searchedPuppies: puppyItems,
          status: PuppyListStatus.success,
        );
      }
    } on Exception {
      return state.copyWith(status: PuppyListStatus.failure);
    }
  }
}
