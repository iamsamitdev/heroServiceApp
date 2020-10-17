import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    String code;
    String status;
    String message;
    Data data;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.empid,
        this.cizid,
        this.imei,
        this.passcode,
        this.prename,
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.tel,
        this.address,
        this.gender,
        this.position,
        this.department,
        this.salary,
        this.birthdate,
        this.avatar,
        this.status,
    });

    String id;
    String empid;
    String cizid;
    String imei;
    String passcode;
    String prename;
    String firstname;
    String lastname;
    String email;
    String password;
    String tel;
    String address;
    String gender;
    String position;
    String department;
    String salary;
    DateTime birthdate;
    String avatar;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        empid: json["empid"] == null ? null : json["empid"],
        cizid: json["cizid"] == null ? null : json["cizid"],
        imei: json["imei"] == null ? null : json["imei"],
        passcode: json["passcode"] == null ? null : json["passcode"],
        prename: json["prename"] == null ? null : json["prename"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        tel: json["tel"] == null ? null : json["tel"],
        address: json["address"] == null ? null : json["address"],
        gender: json["gender"] == null ? null : json["gender"],
        position: json["position"] == null ? null : json["position"],
        department: json["department"] == null ? null : json["department"],
        salary: json["salary"] == null ? null : json["salary"],
        birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
        avatar: json["avatar"] == null ? null : json["avatar"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "empid": empid == null ? null : empid,
        "cizid": cizid == null ? null : cizid,
        "imei": imei == null ? null : imei,
        "passcode": passcode == null ? null : passcode,
        "prename": prename == null ? null : prename,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "tel": tel == null ? null : tel,
        "address": address == null ? null : address,
        "gender": gender == null ? null : gender,
        "position": position == null ? null : position,
        "department": department == null ? null : department,
        "salary": salary == null ? null : salary,
        "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "avatar": avatar == null ? null : avatar,
        "status": status == null ? null : status,
    };
}
