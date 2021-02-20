import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that acts identically to [BlocProvider] except it will close its
/// cubit and recreate it when [input] changes. Currently this does not work
/// for two reasons:
///
///   1. [BlocProvider] will always use the first cubit instance it's given
///      and not update the instance in the context when it changes.
///   2. If the instance in the context did change, [BlocBuilder] will not
///      switch to the new instance.
///
class BlocInputProvider<C extends Cubit, Input> extends StatefulWidget {
  final Input input;
  final C Function(BuildContext, Input) create;
  final Widget child;

  BlocInputProvider({
    Key key,
    @required this.input,
    @required this.create,
    @required this.child,
  }) : assert(child != null);

  @override
  _BlocInputProviderState<C, Input> createState() =>
      _BlocInputProviderState<C, Input>();
}

class _BlocInputProviderState<C extends Cubit, Input>
    extends State<BlocInputProvider<C, Input>> {
  C _cubit;

  @override
  void initState() {
    super.initState();

    _createCubit();
  }

  @override
  void dispose() {
    super.dispose();

    _cubit.close();
  }

  @override
  void didUpdateWidget(covariant BlocInputProvider<C, Input> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.input != oldWidget.input) {
      _cubit.close();

      _createCubit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<C>.value(
      value: _cubit,
      child: widget.child,
    );
  }

  void _createCubit() {
    _cubit = widget.create(context, widget.input);
  }
}
