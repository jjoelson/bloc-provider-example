import 'package:bloc_example/bloc/item_detail_bloc.dart';
import 'package:bloc_example/bloc/items_bloc.dart';
import 'package:bloc_example/model/item.dart';
import 'package:bloc_example/util/bloc_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ItemsBloc()..add(ItemsEventLoadItems()),
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsStateLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ItemsStateLoaded) {
              return Column(
                children: [
                  DropdownButton<Item>(
                    value: state.selectedItem,
                    items: state.items
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text('Item: ${item.id}'),
                          ),
                        )
                        .toList(),
                    onChanged: (newItem) {
                      BlocProvider.of<ItemsBloc>(context).add(
                        ItemsEventSelectItem(newItem),
                      );
                    },
                  ),
                  SizedBox(height: 24),

                  // Currently this doesn't work; when the selected item changes
                  // the new cubit instance created by [BlocInputProvider] does
                  // not get injected into the context.
                  BlocInputProvider(
                    input: state.selectedItem,
                    create: (context, item) =>
                        ItemDetailBloc(item)..add(ItemDetailEvent.loadDetails),
                    child: Expanded(
                      child: DetailWidget(),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
