class Profile {
  String? name;
  String? biography;
  String? instagram;
  String? mail;
  String? phoneNumber;
  String? photo;
  String? cover;
  String? username;
  String? twitter;

  Profile(
      {this.name,
      this.biography,
      this.instagram,
      this.mail,
      this.phoneNumber,
      this.photo,
      this.cover,
      this.username,
      this.twitter});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    biography = json['biography'];
    instagram = json['instagram'];
    mail = json['mail'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    cover = json['cover'];
    username = json['username'];
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'biography': biography,
      'instagram': instagram,
      'mail': mail,
      'phone_number': phoneNumber,
      'photo': photo,
      'cover': cover,
      'username': username,
    };
  }

  @override
  String toString() {
    return 'Profile{name: $name, biography: $biography, instagram: $instagram, mail: $mail, phoneNumber: $phoneNumber, photo: $photo, cover: $cover, username: $username, twitter: $twitter}';
  }
}
