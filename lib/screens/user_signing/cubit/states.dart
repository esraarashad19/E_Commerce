abstract class UserStates {}

class InitialUserState extends UserStates {}

// show or hide password text
class ChangePasswordVisibilityState extends UserStates {}

// user register
class RegisterLoadingState extends UserStates {}

class RegisterSuccessState extends UserStates {}

class RegisterErrorState extends UserStates {
  String? message;
  RegisterErrorState(this.message);
}

// user login
class LoginLoadingState extends UserStates {}

class LoginSuccessState extends UserStates {}

class LoginErrorState extends UserStates {
  String? message;
  LoginErrorState(this.message);
}

// create user login
class CreateUserLoadingState extends UserStates {}

class CreateUserSuccessState extends UserStates {}

class CreateUserErrorState extends UserStates {}
