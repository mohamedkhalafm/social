class PostModel{
  String? name;
  String? uId;
  String? image;
  String? date;
  String? postText;
  String? postImage;
  String? commentText;
  String? commentImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.postImage,
    this.postText, 
    this.commentText,
    this.commentImage


  });

  PostModel.fromJson(Map<String , dynamic>json){
    name = json['name'];
    date = json['date'];
    postImage = json['postImage'];
    postText = json['postText'];
    uId = json['uId'];
    image =json['image'];
    commentText = json['commentText'];
    commentImage = json['commentImage'];
  }

  Map<String , dynamic> toMap(){
    return{ 
      'name' : name,
      'date' : date , 
      'postImage' : postImage ,
      'postText' : postText ,
      'uId' : uId ,
      'image' : image,
      'commentText' : commentText,
      'commentImage' : commentImage
};
}}