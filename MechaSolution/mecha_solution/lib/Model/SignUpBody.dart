class SignUpBody {
  String username;
  String password;
  String repassword;
  String fullname;
  String phone;
  DateTime birthday;
  String work;
  String email;
  String avatar;
  String score;
  int gender;

  SignUpBody(
  {
    this.username,
    this.password,
    this.repassword,
    this.fullname,
    this.phone,
    this.birthday,
    this.work,
    this.email,
    this.avatar,
    this.score,
    this.gender = 1,
  });
}