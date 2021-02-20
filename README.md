# bloc_example

This is a sample application to accompany [this issue](https://github.com/felangel/bloc/issues/2127)
in the `flutter_bloc` package. 

This application is a single page that loads a list of items, and then allows
the user to select one from a drop down list. When an item is selected, 
`ItemDetailBloc` is supposed to load some details for that item and display them
in the tabs. However, because `BlocProvider.value` does not inject subsequent
cubit instances into the context, the details don't change when a new item is 
selected.