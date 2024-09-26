class TodoModel {
  String namalengkap;
  String nomortelepon;
  String alamat1;
  String alamat2;
  String alamat3;
  DateTime createdAt;
  String id;
  String userId;
  TodoModel({
    required this.namalengkap,
    required this.nomortelepon,
    required this.alamat1,
    required this.alamat2,
    required this.alamat3,
    required this.createdAt,
    required this.userId,
    required this.id,
  });

  TodoModel.fromJson(Map<String, dynamic> json, String tempId)
      : namalengkap = json['namalengkap'],
        nomortelepon = json['nomortelepon'],
        alamat1 = json['alamat1'],
        alamat2 = json['alamat2'],
        alamat3 = json['alamat3'],
        createdAt = DateTime.parse(json['createdAt']),
        userId = json['userId'],
        id = tempId;

  Map<String, dynamic> toJson() => {
        'namalengkap': namalengkap,
        'nomortelepon': nomortelepon,
        'alamat1': alamat1,
        'alamat2': alamat2,
        'alamat3': alamat3,
        'createdAt': createdAt.toIso8601String(),
        'userId': userId,
      };
}
