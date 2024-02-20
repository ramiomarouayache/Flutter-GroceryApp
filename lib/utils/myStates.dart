//Simulate a sealed class to customize our state management
class MyState {}

// Subclasses representing different states
class LoadingState extends MyState {}

class LoadedState extends MyState {
  dynamic data;

  LoadedState(this.data);

  //dynamic get data => data;
}

class FailureState extends MyState {
  final String error;

  FailureState(this.error);

  String get errorMessage => error;
}

class EmptyDataState extends FailureState {
  EmptyDataState()
      : super(
            'Your search did not match any product!\n\nSuggestions:\n\n*Try french keywords\n*Try more general keywords');
}

// Additional states for specific scenarios
class NoInternetState extends FailureState {
  NoInternetState() : super('No internet connection');
}
