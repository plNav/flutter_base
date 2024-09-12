
# BLoC

The BLoC pattern (Business Logic Component) is used to manage state and handle events in
a consistent manner. It includes three core files:

- **BLoC class**: Manages business logic and responds to events.
- **Events**: Defines all possible user interactions and system triggers.
- **States**: Manages the state of the BLoC, including statuses and the data being processed.

> The `flutter_bloc` package also allows **dependency injection** by using 
> `RepositoryProvider` and `BlocProvider`.

---

## Table of Contents

1. [Structure](#structure)
    - [BLoC Class](#bloc-class)
    - [Events](#events)
    - [States](#states)
    - [Mandatory Fields](#mandatory-fields-in-bloc)
2. [Usage](#usage)
    - [RepositoryProvider](#repositoryprovider)
    - [BlocProvider](#blocprovider)
    - [Event Loop](#event-loop)
    - [BlocBuilder](#blocbuilder)
    - [BlocListener](#bloclistener)
    - [BlocConsumer](#blocconsumer)
3. [Advanced](#advanced)
    - [Using `buildWhen` and `listenWhen`](#using-buildwhen-and-listenwhen)
    - [Communicating BLoCs](#communicating-blocs)

---

## Structure

### **BLoC Class**

The BLoC class contains the business logic and listens for incoming events. Based on the events, it updates the state and emits it.

```dart
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginService _loginService;

  LoginBloc({required ILoginService loginService})
      : _loginService = loginService,
        super(const LoginState()) {
    on<InputUserEvent>(_onInputUserEvent);
  }

  _onInputUserEvent(InputUserEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: LoginStatus.loading));
    final isAuthenticated = _loginService.login(event.username, '');
    emit(state.copyWith(status: isAuthenticated ? LoginStatus.authSuccess : LoginStatus.authFailed));
  }
}
```
> The BloC class is where the services are injected and used, we use the abstraction to test BloCs with local repositories.


### **Events**

Events represent the user actions or system actions that trigger state changes.

```dart
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class InputUserEvent extends LoginEvent {
  final String username;

  const InputUserEvent({required this.username});

  @override
  List<Object?> get props => [username];
}
```

### **States**

States hold the data for the BLoC and are immutable. Each BLoC should contain a `status` variable of an enum type to represent different stages of state management.

> All the variables in the state must have a default init value or be nullable

```dart
part of 'login_bloc.dart';

enum LoginStatus { loaded, authSuccess, authFailed, authenticating }

final class LoginState extends Equatable {
  final LoginStatus status;

  const LoginState({this.status = LoginStatus.loaded});

  LoginState copyWith({LoginStatus? status}) {
    return LoginState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
```

#### **Mandatory Fields in BLoC**
- **Status Variable**: Every BLoC state must include a `status` variable of an enum type.
- **Handling Nullable Variables in `copyWith`**: If the state contains nullable fields, the `copyWith` method must handle them using a functional approach to avoid accidental `null` overwrites.

```dart
final class LoginState extends Equatable {
  final LoginStatus status;
  final String? exampleNullable;

  const LoginState({
    this.status = LoginStatus.loaded,
    this.exampleNullable,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? Function()? exampleNullable,
  }) {
    return LoginState(
      status: status ?? this.status,
      exampleNullable: exampleNullable == null ? this.exampleNullable : exampleNullable(),
    );
  }
}
```

## Usage

### RepositoryProvider
In a Flutter application, we use RepositoryProvider and MultiRepositoryProvider to inject repositories at the app level. Repositories act as the interface between your business logic and the data layer (e.g., fetching data from APIs or databases). By providing repositories this way, you ensure that they are available across the entire app and that their lifecycle is properly managed.

```dart
RepositoryProvider<ILoginRepository>(
  create: (_) => DioLoginRepository(),
  child: MyApp(),
),
```
You'll see this line in the app file, so depending on the `boolean` we'll inject the local repos or the dio ones.
```dart
return MultiRepositoryProvider(
  providers: isLocalMode ? localRepos : dioRepos,
  child: MaterialApp(
```

### BlocProvider
BlocProvider is a widget that provides an instance of a BLoC to its descendant widgets. This is how you inject the BLoC into the widget tree so that the widgets can interact with it using BlocBuilder, BlocListener, or BlocConsumer.

You can create the bloC
```dart
BlocProvider(
  create: (BuildContext context) => LoginBloc(loginService: context.read<ILoginService>()),
  child: YourWidget(),
);
```

Or use a current one (Recommended for `showDialog` functions)
```dart
BlocProvider.value(
  value: existingLoginBloc,
  child: YourWidget(),
);
```

> `YourWidget` usually it's a complete screen and will provide the bloC in `routes.dart` but you can have more than one bloC for a screen or create new ones for smaller widgets.

Here is how you can provide multiple blocs to a widget:
```dart
MultiBlocProvider(
  providers: [
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(loginService: context.read<ILoginService>()),
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
    ),
  ],
  child: YourWidget(),
);
```


### Event Loop
You can add Events from the bloc itself using `add()` and read the current `state`
```dart
  _onInputUserEvent(InputUserEvent event, Emitter<LoginState> emit) {
    // We can call state variables directly from the bloc
    final currentStatus = state.status;

    // We can read event variables if are defined
    final username = event.username;

    // Only in the BloC is where we can emit new states
    emit(state.copyWith(status: LoginStatus.loading));

    // We can add events from the bloC or from the UI
    add(AfterLoginEvent())
  }
```
> In this example `_onInputUserEvent` will be triggered when a InputUserEvent is added to the bloC

In the UI, if the BloC is Provided you can call it from context:
```dart
  final loginBloc = context.read<LoginBloc>();
```

So you can add events from the UI:
```dart
  loginBloc.add(InputUserEvent(username: "exampleUsername"));
```

But if you need to read the state use the `Builder`, `Listener` or `Consumer` widgets.

### BlocBuilder

`BlocBuilder` listens to the BLoC state and rebuilds the widget when the state changes.

```dart
BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    if (state.status == LoginStatus.authSuccess) {
      return Text('Login Success!');
    } else if (state.status == LoginStatus.authFailed) {
      return Text('Login Failed!');
    } else {
      return CircularProgressIndicator();
    }
  },
)
```

### BlocListener

`BlocListener` listens to the BLoC and allows you to execute side effects based on the state.

```dart
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state.status == LoginStatus.authSuccess) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  },
  child: MyLoginWidget(),
)
```

### BlocConsumer

`BlocConsumer` combines both `BlocBuilder` and `BlocListener` in a single widget.

```dart
BlocConsumer<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state.status == LoginStatus.authSuccess) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  },
  builder: (context, state) {
    if (state.status == LoginStatus.authFailed) {
      return Text('Login Failed!');
    } else {
      return CircularProgressIndicator();
    }
  },
)
```

---

## Advanced

### Using `buildWhen` and `listenWhen`

- **`buildWhen`**: Controls when the `BlocBuilder` rebuilds the widget. It compares the old state and the new state and only rebuilds if the condition is true. **Improves performance**.

```dart
BlocBuilder<LoginBloc, LoginState>(
  buildWhen: (previous, current) {
    return previous.status != current.status; // Only rebuild when status changes
  },
  builder: (context, state) {
    return state.status == LoginStatus.authSuccess
        ? Text('Login Success!')
        : CircularProgressIndicator();
  },
)
```

- **`listenWhen`**: Controls when the `BlocListener` executes its listener. Similar to `buildWhen`, it can filter which states trigger the listener.

```dart
BlocListener<LoginBloc, LoginState>(
  listenWhen: (previous, current) {
    return current.status == LoginStatus.authSuccess; // Only listen when login is successful
  },
  listener: (context, state) {
    Navigator.of(context).pushReplacementNamed('/home');
  },
  child: MyLoginWidget(),
)
```

### Communicating BLoCs

Sometimes, BLoCs need to communicate with each other. For instance, an event in one BLoC might trigger an action in another BLoC. This practice should generally be avoided to prevent coupling, but in complex scenarios, it can be necessary.

In this example, the `LineBloc` depends on `BillBloc`. Whenever the state of `BillBloc` changes (e.g., `BillStatus.loaded`), an event is triggered in `LineBloc` to update its state accordingly.

```dart
class LineBloc extends Bloc<LineEvent, LineState> {
  final BillBloc _billBloc;
  late StreamSubscription _billSubscription;

  LineBloc({required BillBloc billBloc})
      : _billBloc = billBloc,
        super(const LineState()) {
    on<UpdateLinesEvent>(_onUpdateLinesEvent);
    
    // Listen to BillBloc's stream and respond accordingly
    _billSubscription = _billBloc.stream.listen((billState) {
      if (billState.status == BillStatus.loaded) {
        print('BillBloc triggered LineBloc update');
        if (billState.currentBill != null) {
          add(UpdateLinesEvent(products: billState.currentBill!.products));
        }
      }
    });
  }

  // Be sure to cancel the subscription when done
  @override
  Future<void> close() {
    _billSubscription.cancel();
    return super.close();
  }
}
```

--- 

