import 'package:equatable/equatable.dart';
import 'package:flutter_blocs_demo/model/beers_response.dart';

abstract class BeersState extends Equatable {
  const BeersState();
}

class BeersLoading extends BeersState {
  const BeersLoading();

  @override
  List<Object> get props => [];
}

class BeersLoaded extends BeersState {
  final List<BeerResponseModel> beers;

  const BeersLoaded(this.beers);

  @override
  List<Object> get props => [beers];
}

class BeersError extends BeersState {
  final String message;

  const BeersError(this.message);

  @override
  List<Object> get props => [message];
}