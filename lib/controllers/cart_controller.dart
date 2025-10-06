import 'package:flutter/material.dart';
import 'package:jewelry_store/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartController with ChangeNotifier {
  Database? _db;
  List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  Future<void> initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'zyra_cart.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId TEXT NOT NULL,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            imageUrl TEXT,
            quantity INTEGER NOT NULL
          )
        ''');
      },
    );
    await loadCart();
  }

  Future<void> loadCart() async {
    final List<Map<String, dynamic>> maps = await _db!.rawQuery(
      'SELECT * FROM cart',
    );

    _items = maps.map((map) => CartItemModel.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addToCart(CartItemModel item) async {
    final existing = await _db!.rawQuery(
      'SELECT * FROM cart WHERE productId = ?',
      [item.productId],
    );

    if (existing.isNotEmpty) {
      final newQuantity = (existing.first['quantity'] as int? ?? 0) + 1;
      await _db!.rawUpdate('UPDATE cart SET quantity = ? WHERE productId = ?', [
        newQuantity,
        item.productId,
      ]);
    } else {
      await _db!.rawInsert(
        'INSERT INTO cart(productId, name, price, imageUrl, quantity) VALUES(?,?,?,?,?)',
        [item.productId, item.name, item.price, item.imageUrl, item.quantity],
      );
    }

    await loadCart(); // reload to update UI
  }

  Future<void> removeFromCart(String productId) async {
    await _db!.rawDelete('DELETE FROM cart WHERE productId = ?', [productId]);
    await loadCart();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await _db!.rawUpdate('UPDATE cart SET quantity = ? WHERE productId = ?', [
        quantity,
        productId,
      ]);
    }
    await loadCart();
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> clearCart() async {
    if (_db != null) {
      await _db!.rawDelete('DELETE FROM cart'); // clear all rows
    }
    _items.clear(); // clear the local list
    notifyListeners(); // update the UI
  }
}