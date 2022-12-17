// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Anasayfa1 extends StatefulWidget {
  const Anasayfa1({super.key});

  @override
  State<Anasayfa1> createState() => _Anasayfa1State();
}

class _Anasayfa1State extends State<Anasayfa1> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = 5;
  }

  @override
  void dispose() {
    super.dispose();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
            ),
            ElevatedButton(
              onPressed: () => setState(() => count++),
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () async {
                // Normal sayfa geçisi
                // Routes => 1. MaterialPageRoute, 2. CupertinoPageRoute
                // count == 1 ? "evet" : "hayır"
                // ()=>print("deneme")
                int gelenDeger = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Anasayfa2(
                      countDegiskeni: count,
                    ),
                  ),
                );
                setState(() {
                  count = gelenDeger;
                });
                // --------------
                // Geri gidilemez sayfalar için kullanıcacak yapı
                // *** Navigator.pushAndRemoveUntil(
                // ***    context, MaterialPageRoute(builder: (context) => Anasayfa2()), (route) => false);
              },
              child: const Text("2. Sayfaya geç"),
            ),
          ],
        ),
      ),
    );
  }
}

class Anasayfa2 extends StatefulWidget {
  int countDegiskeni;
  Anasayfa2({super.key, required this.countDegiskeni});

  @override
  State<Anasayfa2> createState() => _Anasayfa2State();
}

class _Anasayfa2State extends State<Anasayfa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.countDegiskeni.toString()),
            ElevatedButton(
              onPressed: () => setState(() => widget.countDegiskeni++),
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, widget.countDegiskeni),
              child: const Text("Geri Git"),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiKullanimi extends StatefulWidget {
  const ApiKullanimi({super.key});

  @override
  State<ApiKullanimi> createState() => _ApiKullanimiState();
}

class _ApiKullanimiState extends State<ApiKullanimi> {
  final dio = Dio();

  Future<UsersModel?> fetch() async {
    const String url = "https://reqres.in/api/users?page=2";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        // 200 başarılı istek sonucunda dönen kod
        // burda istek başarılıdır, değer return edeceğiz.
        return UsersModel.fromJson(response.data);
      } else {
        // istek başarasız oldu ve veri null döndü
        return null;
      }
    } catch (e) {
      print("Alınan hata: $e");
      return null;
    }
  }

  Future<bool?> postIslemi() async {
    const String url = "https://reqres.in/api/users";
    final gonderilecekData = {"name": nameController.text, "job": jobController.text};
    try {
      final response = await dio.post(url);
      if (response.statusCode == 201) {
        // 201 başarılı istek sonucunda dönen kod
        // burda istek başarılıdır, değer return edeceğiz.
        print(response.data);
        return true;
      } else {
        // istek başarasız oldu ve veri null döndü
        return false;
      }
    } catch (e) {
      print("Alınan hata: $e");
      return null;
    }
  }

  UsersModel? gelenData;
  bool isLoading = false;
  bool isError = false;

  void apiyiCagir() {
    setState(() {
      isLoading = true;
    });
    fetch().then((value) {
      if (value != null) {
        setState(() {
          gelenData = value;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    });
  }

  final nameController = TextEditingController();
  final jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiyiCagir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Kullanımı"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isError == true
              ? const Center(
                  child: Icon(
                    Icons.error,
                    size: 72,
                    color: Colors.red,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "İsim",
                        ),
                      ),
                      TextField(
                        controller: jobController,
                        decoration: const InputDecoration(
                          labelText: "Meslek",
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            postIslemi().then((value) {
                              if (value == true) {
                                print("Veriler başarılı bir şekilde gönderildi");
                              } else {
                                print("Veriler gönderme işlemi başarısız oldu");
                              }
                            });
                          },
                          child: const Text("Verileri Gönder")),
                      Expanded(
                        child: ListView.builder(
                          itemCount: gelenData?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = gelenData?.data?[index];
                            return ListTile(
                              title: Text(item?.firstName ?? "İsim boş geldi"),
                              subtitle: Text(item?.email ?? "İsim boş geldi"),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(item?.avatar ?? ""),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UsersModelSupport {
/*
{
  "url": "https://reqres.in/#support-heading",
  "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
} 
*/

  String? url;
  String? text;

  UsersModelSupport({
    this.url,
    this.text,
  });
  UsersModelSupport.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    text = json['text']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}

class UsersModelData {
/*
{
  "id": 7,
  "email": "michael.lawson@reqres.in",
  "first_name": "Michael",
  "last_name": "Lawson",
  "avatar": "https://reqres.in/img/faces/7-image.jpg"
} 
*/

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UsersModelData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });
  UsersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    avatar = json['avatar']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class UsersModel {
/*
{
  "page": 2,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 7,
      "email": "michael.lawson@reqres.in",
      "first_name": "Michael",
      "last_name": "Lawson",
      "avatar": "https://reqres.in/img/faces/7-image.jpg"
    }
  ],
  "support": {
    "url": "https://reqres.in/#support-heading",
    "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
  }
} 
*/

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UsersModelData?>? data;
  UsersModelSupport? support;

  UsersModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });
  UsersModel.fromJson(Map<String, dynamic> json) {
    page = json['page']?.toInt();
    perPage = json['per_page']?.toInt();
    total = json['total']?.toInt();
    totalPages = json['total_pages']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <UsersModelData>[];
      v.forEach((v) {
        arr0.add(UsersModelData.fromJson(v));
      });
      this.data = arr0;
    }
    support = (json['support'] != null) ? UsersModelSupport.fromJson(json['support']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}
