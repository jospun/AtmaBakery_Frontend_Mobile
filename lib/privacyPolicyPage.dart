import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPage();
}

class _PrivacyPolicyPage extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is the privacy Policy"),
    );
  }
}
