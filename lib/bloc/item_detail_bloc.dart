import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/item.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  final Item item;

  ItemDetailBloc(this.item) : super(ItemDetailStateInitial());

  @override
  Stream<ItemDetailState> mapEventToState(ItemDetailEvent event) async* {
    switch (event) {
      case ItemDetailEvent.loadDetails:
        yield ItemDetailStateLoading();
        await Future.delayed(Duration(seconds: 4));
        yield ItemDetailStateLoaded(
          someProperty: 'Some property for item ${item.id}',
          someOtherProperty: 'Some other property for item ${item.id}',
        );
    }
  }
}

abstract class ItemDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemDetailStateInitial extends ItemDetailState {}

class ItemDetailStateLoading extends ItemDetailState {}

class ItemDetailStateLoaded extends ItemDetailState {
  final String someProperty;
  final String someOtherProperty;

  ItemDetailStateLoaded({
    @required this.someProperty,
    @required this.someOtherProperty,
  });

  @override
  List<Object> get props => [someProperty, someOtherProperty];
}

enum ItemDetailEvent { loadDetails }
