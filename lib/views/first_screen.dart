import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/viewmodels/first_viewmodel.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late TextEditingController nameController;
  late TextEditingController palindromeController;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FirstViewModel>(context, listen: false);

    nameController = TextEditingController(text: viewModel.name);
    palindromeController = TextEditingController(text: viewModel.palindrome);

    nameController.addListener(() {
      viewModel.setName(nameController.text);
    });

    palindromeController.addListener(() {
      viewModel.setPalindrome(palindromeController.text);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FirstViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromRGBO(180, 220, 225, 0.6),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person_add_alt_1,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 64),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: palindromeController,
                              decoration: const InputDecoration(
                                hintText: 'Palindrome',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!viewModel.hasValidPalindromeInput) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Palindrome input cannot be empty',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final isPalin = viewModel.isPalindrome();
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(
                                        isPalin
                                            ? 'Is Palindrome'
                                            : 'Not Palindrome',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2B637B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                ),
                                child: const Text(
                                  'CHECK',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (viewModel.name.trim().isEmpty) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentMaterialBanner();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Name cannot be empty'),
                                      ),
                                    );
                                    return;
                                  }

                                  Navigator.pushNamed(context, '/secondScreen');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2B637B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                ),
                                child: const Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
