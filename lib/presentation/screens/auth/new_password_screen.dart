import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color orangeColor = Color(0xffFA6E21);
    const Color grayInputColor = Color(0xffF3F4F6);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        primary:
            false, // Don't take up space equivalent to status bar if safe area handles it, but here just standard
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: Colors.black), // If back is allowed
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double contentWidth = constraints.maxWidth;
            bool isWide = constraints.maxWidth > 600;
            if (isWide) contentWidth = 400;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        AppStrings.newPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        AppStrings.newPasswordSub,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // New Password Field
                      _buildLabel(AppStrings.newPassword),
                      const SizedBox(height: 8),
                      _buildTextField(
                        AppStrings.writePassword,
                        grayInputColor,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),

                      // Repeat Password Field
                      _buildLabel(AppStrings.repeatPassword),
                      const SizedBox(height: 8),
                      _buildTextField(
                        AppStrings.writePassword,
                        grayInputColor,
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),

                      // Send Button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Handle Password Reset
                          // Navigate back to Login or success
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orangeColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          AppStrings.send,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    Color fillColor, {
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
