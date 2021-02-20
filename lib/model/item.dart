import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;

  Item(this.id);

  @override
  List<Object> get props => [id];
}
