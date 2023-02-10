import 'package:equatable/equatable.dart';

abstract class BeersEvent extends Equatable {
  const BeersEvent();
}

class BeersFetched extends BeersEvent {
  const BeersFetched();

  @override
  List<Object> get props => [];
}