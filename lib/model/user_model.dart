class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.cover,
    this.bio
  });

  UserModel.fromJson(Map<String , dynamic>json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    bio = json['bio'];
    cover =json['cover'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image =json['image'];
  }

  Map<String , dynamic> toMap(){
    return{ 'name' : name,
    'email' : email , 
    'phone' : phone ,
    'uId' : uId ,
    'isEmailVerified' : isEmailVerified,
    'image' : image,
    'cover' : cover,
    'bio' : bio
};
}}