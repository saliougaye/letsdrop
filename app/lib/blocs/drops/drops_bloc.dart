import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/services/api_service.dart';

part 'drops_event.dart';
part 'drops_state.dart';

class DropsBloc extends Bloc<DropsEvent, DropsState> {

  final ApiService apiService;

  DropsBloc({ required this.apiService }) : super(DropsLoading()) {
    on<LoadDrops>(_onLoadDrops);
    on<AddDrop>(_onAddDrops);
    on<DeleteDrop>(_onDeleteDrops);
  }

  FutureOr<void> _onLoadDrops(LoadDrops event, Emitter<DropsState> emit) async {

    try {
      
      final drops = await apiService.getDrops();
      
      emit(
        DropsLoaded(
          drops: drops
        )
      );


    } catch (e) {
      emit(
        DropsLoadingFailed()
      );
    }


  }

  FutureOr<void> _onAddDrops(AddDrop event, Emitter<DropsState> emit) async {
    
    final state = this.state;

    if(state is DropsLoaded) {

      try {
        
        final dropCreated = await apiService.createDrop(event.drop);

        emit(
          DropsLoaded(
            drops: List.from(state.drops)..add(dropCreated)
          )
        );
      
      } catch (e) {
        emit(
          DropsCreationFailed()
        );
      }
    }

  }

  FutureOr<void> _onDeleteDrops(DeleteDrop event, Emitter<DropsState> emit) async {

    final state = this.state;

    if(state is DropsLoaded) {

      try {
        
        final dropDeleted = await apiService.deleteDrop(event.drop.id);

        emit(
          DropsLoaded(
            drops: List.from(state.drops)..where((element) => element.id != dropDeleted.id)
          )
        );
      
      } catch (e) {
        emit(
          DeleteDropFailed(
            drops: state.drops
          )
        );
      }
    }
  }
}
