abstract class MessagesStates {}

class MessagesInitialState extends MessagesStates {}

class SendMessagesLoadingState extends MessagesStates {}

class SendMessagesSuccessState extends MessagesStates {}

class SendMessagesErrorState extends MessagesStates {}

class RecieveMessagesLoadingState extends MessagesStates {}

class RecieveMessagesSuccessState extends MessagesStates {}

class RecieveMessagesErrorState extends MessagesStates {}

class GetMessagesSuccessState extends MessagesStates {}
