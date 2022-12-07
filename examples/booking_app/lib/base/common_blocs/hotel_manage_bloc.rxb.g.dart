// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'hotel_manage_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class HotelManageBlocType extends RxBlocTypeBase {
  HotelManageBlocEvents get events;
  HotelManageBlocStates get states;
}

/// [$HotelManageBloc] extended by the [HotelManageBloc]
/// {@nodoc}
abstract class $HotelManageBloc extends RxBlocBase
    implements
        HotelManageBlocEvents,
        HotelManageBlocStates,
        HotelManageBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [markAsFavorite]
  final _$markAsFavoriteEvent = PublishSubject<_MarkAsFavoriteEventArgs>();

  @override
  void markAsFavorite({
    required Hotel hotel,
    required bool isFavorite,
  }) =>
      _$markAsFavoriteEvent.add(_MarkAsFavoriteEventArgs(
        hotel: hotel,
        isFavorite: isFavorite,
      ));

  @override
  HotelManageBlocEvents get events => this;

  @override
  HotelManageBlocStates get states => this;

  @override
  void dispose() {
    _$markAsFavoriteEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}

/// Helps providing the arguments in the [Subject.add] for
/// [HotelManageBlocEvents.markAsFavorite] event
class _MarkAsFavoriteEventArgs {
  const _MarkAsFavoriteEventArgs({
    required this.hotel,
    required this.isFavorite,
  });

  final Hotel hotel;

  final bool isFavorite;
}
