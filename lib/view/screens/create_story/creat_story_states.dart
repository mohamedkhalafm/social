abstract class CreateStoryStates{}

class CreateStoryInitialState extends CreateStoryStates{}


class CreateStoryLoadingState extends CreateStoryStates{}

class CreateStorySuccessState extends CreateStoryStates{}

class CreateStoryErrorState extends CreateStoryStates{}

class GetStoryImageLoadingState extends CreateStoryStates{}


class GetStoryImageSuccessState extends CreateStoryStates{}
class GetStoryImageErrorState extends CreateStoryStates{}






//class GetStoryLoadingState extends CreateStoryStates{}


//class GetStorySuccessState extends CreateStoryStates{}







class CreateStoryImagePickedSucces extends CreateStoryStates{}

class CreateStoryImagePickederror extends CreateStoryStates{}


class StoryRemoveImage extends CreateStoryStates{}


class AddTextSuccessState extends CreateStoryStates{}


class CloseStoryScreenState extends CreateStoryStates{}