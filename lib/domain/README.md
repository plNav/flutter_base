
# Domain Layer

The **domain** layer is responsible for the business logic and core functionality of the application. It contains all the components that interact with data, such as API clients, repositories, and services. This layer **must not** depend on the UI and is the backbone of the app’s business logic.

---

## Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Clients](#clients)
- [Repositories](#repositories)
- [Services](#services)

---

## Overview

The **domain** folder contains the following subdirectories:

- **clients/**: Classes for API clients and network interactions.
- **repositories/**: Contains the repository layer, which manages data sources. This includes abstractions for easy testing and multiple implementations.
- **services/**: Business operations are handled by services that interact with repositories and clients.

---

## Directory Structure

The domain layer is organized into the following directories:

```
domain/
├── clients/           # Classes for API or other clients that can be used in services.
├── repositories/      # Data repositories to manage data sources.
│   ├── abstractions/  # Interfaces for repository abstractions.
│   ├── dio/           # Repositories interacting with APIs via Dio.
│   └── local/         # Repositories interacting with local data sources.
├── services/          # Service classes for handling business operations.
    ├── abstractions/  # Interfaces for service abstractions.
    └── implementations/ # Service implementations using repositories.
```

---

## Clients

The **clients/** directory contains classes responsible for interacting with external systems like APIs and performing network operations. These classes are reusable and can be used across different repositories or services to handle network communication, encryption, and connectivity.

Clients are not limited to data exchange. They can also include utility classes like **CryptoClient** for encryption and **ConnectionClient** for checking internet connectivity, which can be leveraged by the service layer to enhance business operations.

> Each client are self-explained in file comments.

---

## Repositories

The **repositories/** directory holds the data repositories, which are responsible for
managing data sources and retrieving or storing data from APIs or local storage.
Each repository has an abstraction (interface) and can have multiple implementations (e.g.,
Dio for network-based repositories and local for offline storage).

> Repositories should recieve `Models` or `Primitives` as parameters and returns only `Models` or
> `Primitives`, here is where we can convert this data `from` and `to` a `Dto`

### Structure:
- **abstractions/**: Contains repository interfaces that define the contracts for repository implementations.
- **dio/**: Repositories that use Dio for network-based operations.
- **local/**: Repositories that manage local data storage.

Repositories play a crucial role in decoupling the data layer from the business logic, making the code easier to scale and test.

### Code Samples:

#### **ILoginRepository**
```dart
abstract class ILoginRepository {
  FutureOr<String> login(User user);
  FutureOr<User> getUserData();
}
```
#### **LocalLoginRepository**
```dart
class LocalLoginRepository implements ILoginRepository {
  @override
  FutureOr<User> getUserData() {
    const harcodedUserForTesting = User(id: 'id', name: 'name');
    return harcodedUserForTesting;
  }

  @override
  FutureOr<String> login(User user) {
    return user.name;
  }
}
```

#### **DioLoginRepository**
```dart
class DioLoginRepository extends IDioRepository implements ILoginRepository {
  DioLoginRepository({super.url = '/login'});

  @override
  FutureOr<User> getUserData() async {
    final loginEndpoint = '$url/user';
    final res = await dio.get(loginEndpoint);
    final json = await res.data;
    final UserDto user = UserDto.fromJson(json);
    return user.toUser();
  }

  @override
  FutureOr<String> login(User user) async {
    final loginEndpoint = '$url/auth';
    final data = UserDto.fromUser(user).toJson();
    final res = await dio.post(loginEndpoint, data: data);
    final json = await res.data;
    final LoginResponseDto loginDto = LoginResponseDto.fromJson(json);
    if (loginDto.token.isNotEmpty) {
      dioClient.setToken(loginDto.token);
    }
    return loginDto.username;
  }
}
```

> We extend from IDioRepository to define in every repository the common `url` fragment 
> and ensure the use of the dio client.

> Check how we set the token in the login function to inject it in every other request. 

---

## Services

The **services/** directory contains service classes that handle the core business operations
of the application. Services interact with repositories to retrieve or manipulate data as part
of the business logic. They also serve as a middle layer between repositories and higher-level
components like BLoCs or user-facing widgets.

> Services are injected in `BloCs`

### Structure:
- **abstractions/**: Interfaces that define the contract for service implementations.
- **implementations/**: The actual service classes that use repositories to perform business operations.

### Code Samples:

#### **ILoginService**
```dart
abstract class ILoginService {
  Future<void> login(String email, String password);
}
```

#### **LoginService**
```dart
class LoginService implements ILoginService {
  final ILoginRepository _loginRepository;

  LoginService({required ILoginRepository loginRepository}) : _loginRepository = loginRepository;

  @override
  Future<String> login(String email, String password) async {
    return _loginRepository.login(email, password);
  }
}
```

---
