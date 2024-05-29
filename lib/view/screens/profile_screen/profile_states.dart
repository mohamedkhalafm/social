abstract class ProfileStates{}

class ProfileInitialState extends ProfileStates{}

class ProfileGetUserLoadingState extends ProfileStates{}

class ProfileGetUserSuccessState extends ProfileStates{}

class ProfileGetUserErrorState extends ProfileStates{
  final String error;

  ProfileGetUserErrorState(this.error);

}

class ProfileImagePickedSucces extends ProfileStates{}

class ProfileImagePickederror extends ProfileStates{}

class CoverImagePickedSuccess extends ProfileStates{}

class CoverImagePickederror extends ProfileStates{}



class PostImagePickedSucces extends ProfileStates{}

class PostImagePickedError extends ProfileStates{}


class UserUpdateLoadingState extends ProfileStates{}
class UserUpdateSuccessState extends ProfileStates{}
class UserUpdateErrorState extends ProfileStates{}
