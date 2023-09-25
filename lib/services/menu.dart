import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuData {
  final int id;
  final String nama;
  final int harga;
  final String tipe;
  final String gambar;

  MenuData({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      tipe: json['tipe'],
      gambar: json['gambar'],
    );
  }
}

Future<List<MenuData>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://tes-mobile.landa.id/api/menus'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final List<dynamic> menuItems = jsonData['datas'];

    return menuItems.map((data) => MenuData.fromJson(data)).toList();
  } else {
    throw Exception('Gagal mengambil data dari API');
  }
}
