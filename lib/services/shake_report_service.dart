import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShakeReportService {
  final BuildContext context;
  final double shakeThreshold;
  StreamSubscription<AccelerometerEvent>? _subscription;
  DateTime _lastShakeTime = DateTime.now();

  ShakeReportService({required this.context, this.shakeThreshold = 15});

  void startListening() {
    _subscription = accelerometerEvents.listen((event) {
      double acceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );
      if (acceleration > shakeThreshold) {
        final now = DateTime.now();
        if (now.difference(_lastShakeTime) > const Duration(seconds: 1)) {
          _lastShakeTime = now;
          _onShakeDetected();
        }
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void _onShakeDetected() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Shake Detected"),
            content: const Text("Do you want to report an issue?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _reportIssue();
                },
                child: const Text("Report"),
              ),
            ],
          ),
    );
  }

  Future<void> _reportIssue() async {
    // Request contacts permission
    bool contactsGranted = await _requestPermission(Permission.contacts);
    if (!contactsGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contacts permission denied")),
      );
      return;
    }

    bool fcGranted = await FlutterContacts.requestPermission();
    if (!fcGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Contacts permission denied (FlutterContacts)"),
        ),
      );
      return;
    }

    // Request phone permission
    bool phoneGranted = await _requestPermission(Permission.phone);
    if (!phoneGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Phone permission denied")));
      return;
    }

    List<Contact> contacts = await FlutterContacts.getContacts(
      withProperties: true,
    );
    if (contacts.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No contacts found")));
      return;
    }

    Contact contact = contacts.firstWhere(
      (c) => c.phones.isNotEmpty,
      orElse: () => contacts.first,
    );

    if (contact.phones.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No contacts with phone numbers found")),
      );
      return;
    }

    String number = contact.phones.first.number;
    await _callNumber(number);
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }
    return status.isGranted;
  }

  Future<void> _callNumber(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cannot launch call")));
    }
  }
}
