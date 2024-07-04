import 'dart:convert';

List<ServiceProviderReqResModel> serviceProviderReqResModelFromJson(
        String str) =>
    List<ServiceProviderReqResModel>.from(
        json.decode(str).map((x) => ServiceProviderReqResModel.fromJson(x)));

String serviceProviderReqResModelToJson(
        List<ServiceProviderReqResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceProviderReqResModel {
  String? images;
  String? did;
  String? email;
  String? useraadharcard;
  String? services;
  String? fname;
  String? uid;
  String? lname;
  String? status;
  String? contact;
  String? address;
  String? password;
  String? contactOptional;

  ServiceProviderReqResModel({
    this.images,
    this.did,
    this.email,
    this.useraadharcard,
    this.services,
    this.fname,
    this.uid,
    this.lname,
    this.status,
    this.contact,
    this.address,
    this.password,
    this.contactOptional,
  });

  factory ServiceProviderReqResModel.fromJson(Map<String, dynamic> json) =>
      ServiceProviderReqResModel(
        images: json["Images"],
        did: json["did"],
        email: json["email"],
        useraadharcard: json["useraadharcard"],
        services: json["services"],
        fname: json["fname"],
        uid: json["Uid"],
        lname: json["lname"],
        status: json["status"],
        contact: json["contact"],
        address: json["address"],
        password: json["password"],
        contactOptional: json["contact(optional)"],
      );

  Map<String, dynamic> toJson() => {
        "Images": images,
        "did": did,
        "email": email,
        "useraadharcard": useraadharcard,
        "services": services,
        "fname": fname,
        "Uid": uid,
        "lname": lname,
        "status": status,
        "contact": contact,
        "address": address,
        "password": password,
        "contact(optional)": contactOptional,
      };
}
