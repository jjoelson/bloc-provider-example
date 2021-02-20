import 'package:bloc_example/model/item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsStateInitial());

  @override
  Stream<ItemsState> mapEventToState(event) async* {
    if (event is ItemsEventLoadItems) {
      yield ItemsStateLoading();

      await Future.delayed(Duration(seconds: 1));

      final items = [Item(1), Item(2), Item(3)];
      yield ItemsStateLoaded(
        items: items,
        selectedItem: items[0],
      );
    } else if (event is ItemsEventSelectItem) {
      final currentState = state;
      if (currentState is ItemsStateLoaded) {
        yield ItemsStateLoaded(
          items: currentState.items,
          selectedItem: event.item,
        );
      }
    }
  }
}

abstract class ItemsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemsStateInitial extends ItemsState {}

class ItemsStateLoading extends ItemsState {}

class ItemsStateLoaded extends ItemsState {
  final List<Item> items;
  final Item selectedItem;

  ItemsStateLoaded({
    @required this.items,
    @required this.selectedItem,
  });

  @override
  List<Object> get props => super.props..addAll([items, selectedItem]);
}

abstract class ItemsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemsEventLoadItems extends ItemsEvent {}

class ItemsEventSelectItem extends ItemsEvent {
  final Item item;

  ItemsEventSelectItem(this.item);

  @override
  List<Object> get props => super.props..addAll([item]);
}
