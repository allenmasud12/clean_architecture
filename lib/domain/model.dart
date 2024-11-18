class SliderObject{
  String title;
  String subTitle;
  String image;

 SliderObject(this.title, this.subTitle, this.image);
}

class User{
  String id;
  String name;
  int numOfNotification;
  User(this.id, this.name, this.numOfNotification);
}

class Contact{
  String email;
  String phone;
  String link;

  Contact(this.email, this.phone, this.link);
}

class Authentication{
  User? user;
  Contact? contact;
  Authentication(this.user, this.contact);
}