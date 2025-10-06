import 'package:flutter/material.dart';
import 'package:jewelry_store/models/order_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderController with ChangeNotifier {
  Database? _db;

  Future<void> initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'jewelry.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            total REAL,
            customer_name TEXT,
            email TEXT,
            address TEXT,
            payment_method TEXT,
            card_number TEXT,
            card_expiry TEXT,
            card_cvv TEXT,
            order_date TEXT,
            delivery_date TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS order_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            product_id TEXT,
            name TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> createOrder(OrderModel order, List cartItems) async {
    if (_db == null) {
      throw Exception('Database is not initialized');
    }
    final orderId = await _db!.insert('orders', order.toMap());
    for (var item in cartItems) {
      await _db!.insert('order_items', {
        'order_id': orderId,
        'product_id': item.productId,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
      });
    }
    return orderId;
  }
}