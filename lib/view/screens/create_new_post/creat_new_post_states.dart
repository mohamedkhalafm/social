abstract class CreatePostStates{}

class CreatePostInitialState extends CreatePostStates{}


class CreatePostLoadingState extends CreatePostStates{}

class CreatePostSuccessState extends CreatePostStates{}

class CreatePostErrorState extends CreatePostStates{}

class CreatePostImagePickedSucces extends CreatePostStates{}

class CreatePostImagePickederror extends CreatePostStates{}

class PostRemoveImage extends CreatePostStates{}


class PostImagePickedSucces extends CreatePostStates{}


class PostImagePickedError extends CreatePostStates{}