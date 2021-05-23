import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:favorites_advanced_base/core.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/base/common_blocs/coordinator_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'puppy_details_event.dart';

part 'puppy_details_state.dart';

class PuppyDetailsBloc extends Bloc<PuppyDetailsEvent, PuppyDetailsState> {
  PuppyDetailsBloc({
    required CoordinatorBloc coordinatorBloc,
    required Puppy puppy,
  })   : _coordinatorBloc = coordinatorBloc,
        _puppy = puppy,
        super(PuppyDetailsState(puppy: puppy)) {
    _coordinatorBloc.stream
        .whereType<CoordinatorFavoritePuppyUpdatedState>()
        .listen((state) => add(PuppyDetailsEvent(
              puppy: state.favoritePuppy,
              updateException: state.updateException,
            )))
        .addTo(_compositeSubscription);
  }

  final CoordinatorBloc _coordinatorBloc;
  late final Puppy? _puppy; //comes from the search or favorites pages
  final _compositeSubscription = CompositeSubscription();

  @override
  Stream<PuppyDetailsState> mapEventToState(
    PuppyDetailsEvent event,
  ) async* {
    final puppy = event.puppy;
    if (event.updateException.isEmpty) {
      yield state.copyWith(
          puppy: _puppy!.copyWith(isFavorite: puppy.isFavorite));
    } else {
      yield state.copyWith(
          puppy: puppy.copyWith(isFavorite: !puppy.isFavorite));
      // On details page, when there is no internet, the favorite icon is
      // not rebuilding without the delay
      await Future.delayed(const Duration(milliseconds: 400));
      yield state.copyWith(puppy: puppy.copyWith(isFavorite: puppy.isFavorite));
    }
  }

  @override
  Future<void> close() {
    _compositeSubscription.dispose();
    return super.close();
  }
}
