
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocs_demo/blocs/beers_event.dart';
import 'package:flutter_blocs_demo/blocs/beers_states.dart';

import '../repository/beers_repository.dart';

class BeersBloc extends Bloc<BeersEvent, BeersState> {
  final BeersRepository beersRepository;
  BeersBloc({required this.beersRepository}) : super(const BeersLoading()){
    on<BeersFetched>((event, emit) async {
      emit(const BeersLoading());
      try{
        /*final beers = await beersRepository.getBeers();
        emit(BeersLoaded(beers));*/
        final beers = await beersRepository.getBeers();
        beers.fold((left) => emit(BeersError(left)), (right) => emit(BeersLoaded(right)));
      } catch (e) {
        emit(BeersError(e.toString()));
      }
    });
  }
}