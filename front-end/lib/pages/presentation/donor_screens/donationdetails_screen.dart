import 'package:flutter/material.dart';

class DonationDetailsInput extends StatefulWidget {
  final String category;

  const DonationDetailsInput({super.key, this.category = "Food"});

  @override
  State<DonationDetailsInput> createState() => _DonationDetailsInputState();
}

class _DonationDetailsInputState extends State<DonationDetailsInput> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final pickupTimeController = TextEditingController();
  final pickupLocationController = TextEditingController();

  void submit(String route) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        route,
        arguments: {
          "category": widget.category,
          "description": descriptionController.text,
          "quantity": quantityController.text,
          "pickupTime": pickupTimeController.text,
          "pickupLocation": pickupLocationController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text("Donation Details",
                        style: TextStyle(fontSize: 22)),
                  ],
                ),

                const SizedBox(height: 20),

                /// Category
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF529160).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Category: ${widget.category}",
                    style: const TextStyle(color: Color(0xFF529160)),
                  ),
                ),

                const SizedBox(height: 24),

                /// Description
                buildField(
                  "Description",
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                    decoration: inputDecoration("Describe your donation..."),
                  ),
                ),

                /// Quantity
                buildField(
                  "Quantity",
                  TextFormField(
                    controller: quantityController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                    decoration: inputDecoration("Enter quantity"),
                  ),
                ),

                /// Pickup Time
                buildField(
                  "Pickup Time",
                  TextFormField(
                    controller: pickupTimeController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                    decoration: inputDecoration("Select time")
                        .copyWith(prefixIcon: const Icon(Icons.calendar_today)),
                  ),
                ),

                /// Pickup Location
                buildField(
                  "Pickup Location",
                  TextFormField(
                    controller: pickupLocationController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                    decoration: inputDecoration("Enter location")
                        .copyWith(prefixIcon: const Icon(Icons.location_on)),
                  ),
                ),

                const SizedBox(height: 30),

                const Text("Choose how to select a charity"),

                const SizedBox(height: 16),

                /// Button 1
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF529160),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => submit("/choosecharity_screen"),
                  child: const Column(
                    children: [
                      Text("Select Specific Charity"),
                      Text("Browse manually",
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// Button 2
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF529160), width: 2),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => submit("/Ai_match_screen"),
                  child: const Column(
                    children: [
                      Text("AI Matching System"),
                      Text("Recommended",
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String title, Widget field) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 10),
          field,
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
