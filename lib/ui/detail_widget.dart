import 'package:bloc_example/bloc/item_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailWidget extends StatefulWidget {
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _controller,
          tabs: [Text('Tab 1'), Text('Tab 2')],
          labelColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
        ),
        Expanded(
          child: _selectedTabIndex == 0 ? _DetailTabOne() : _DetailTabTwo(),
        ),
      ],
    );
  }
}

class _DetailTabOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      builder: (context, state) {
        if (state is ItemDetailStateLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading tab 1..."),
              CircularProgressIndicator(),
            ],
          );
        } else if (state is ItemDetailStateLoaded) {
          return Center(
            child: Text(state.someProperty),
          );
        }

        return Container();
      },
    );
  }
}

class _DetailTabTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      builder: (context, state) {
        if (state is ItemDetailStateLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading tab 2..."),
              CircularProgressIndicator(),
            ],
          );
        } else if (state is ItemDetailStateLoaded) {
          return Center(
            child: Text(state.someOtherProperty),
          );
        }

        return Container();
      },
    );
  }
}
