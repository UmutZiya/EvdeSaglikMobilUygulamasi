class UserModel {
  final String? nameSurname;
  final String? phone;
  final bool? doctor;
  final int? created;
  final String? uid;

  UserModel({
    required this.nameSurname,
    required this.created,
    required this.doctor,
    required this.phone,
    required this.uid,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> map) => UserModel(
        nameSurname: map['nameSurname'] ?? '',
        doctor: map['doctor'] ?? false,
        created: map['created'] ?? 0,
        phone: map['phone'] ?? '',
        uid: map['uid'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'nameSurname': nameSurname,
        'created': created,
        'doctor': doctor,
        'phone': phone,
        'uid': uid,
      };
}
