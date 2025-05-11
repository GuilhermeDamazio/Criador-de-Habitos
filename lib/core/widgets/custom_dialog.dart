import 'package:flutter/material.dart';

class CustomSuccessDialog extends StatelessWidget {
  final VoidCallback onCreateNew;
  final VoidCallback onContinue;

  const CustomSuccessDialog({
    super.key,
    required this.onCreateNew,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/sucess_image.png',
                      height: 160,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'PARABÉNS!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Parabéns! Seu novo hábito foi adicionado com sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onCreateNew,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Criar novo hábito'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: onContinue,
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
