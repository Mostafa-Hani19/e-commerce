import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/user_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  final Address? initialAddress;

  const AddAddressScreen({super.key, this.initialAddress});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _numberController;
  late TextEditingController _zipcodeController;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.initialAddress?.city);
    _streetController = TextEditingController(
      text: widget.initialAddress?.street,
    );
    _numberController = TextEditingController(
      text: widget.initialAddress?.number.toString(),
    );
    _zipcodeController = TextEditingController(
      text: widget.initialAddress?.zipcode,
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final newAddress = Address(
        city: _cityController.text,
        street: _streetController.text,
        number: int.tryParse(_numberController.text) ?? 0,
        zipcode: _zipcodeController.text,
        geolocation:
            widget.initialAddress?.geolocation ??
            Geolocation(lat: '0', long: '0'), // Mock geolocation
      );

      ref.read(userProvider.notifier).updateAddress(newAddress);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialAddress != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? AppStrings.editAddress : AppStrings.addNewAddress,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _cityController,
                label: AppStrings.city,
                validator: (v) =>
                    v?.isNotEmpty == true ? null : AppStrings.requiredField,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _streetController,
                label: AppStrings.street,
                validator: (v) =>
                    v?.isNotEmpty == true ? null : AppStrings.requiredField,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _numberController,
                      label: AppStrings.number,
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isNotEmpty == true
                          ? null
                          : AppStrings.requiredField,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _zipcodeController,
                      label: AppStrings.zipcode,
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isNotEmpty == true
                          ? null
                          : AppStrings.requiredField,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.orangeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEditing
                        ? AppStrings.updateAddress
                        : AppStrings.saveAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppTheme.orangeColor),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
