import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wishlist/screens/home_screen/home_screen.dart';
import 'package:wishlist/screens/register_screen/register_screen.dart';
import 'package:wishlist/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  static final Future<void> _googleSignInInitialization =
  GoogleSignIn.instance.initialize();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signInWithEmail() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showError('Email and password must not be empty');
      return;
    }
    setState(() => isLoading = true);
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      _showError('Login error: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> signInWithGoogle() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final googleSignIn = GoogleSignIn.instance;

      await _googleSignInInitialization;

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final OAuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        _showError('Google sign in error: ${e.code}');
      }
    } on FirebaseAuthException catch (e) {
      _showError('Firebase login error: ${e.message ?? e.code}');
    } catch (e) {
      _showError('Google sign in error: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC9C6FF),
              Color(0xFFE0DFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back ✨',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF392D75),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Log in to access your wishlists',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF9373A7),
                      ),
                    ),
                    const SizedBox(height: 35),
                    AppTextField(
                      controller: emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 15),
                    AppTextField(
                      controller: passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(height: 25),

                    _buildGradientButton(
                      text: 'Login',
                      onTap: signInWithEmail,
                    ),
                    const SizedBox(height: 25),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Color(0xFF9373A7), thickness: 0.5)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Color(0xFF9373A7), fontSize: 13),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFF9373A7), thickness: 0.5)),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildSocialButton(
                      text: 'Continue with Apple',
                      icon: Icons.apple,
                      iconColor: Colors.white,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onTap: () {
                        // Apple Sign-In
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildSocialButton(
                      text: 'Continue with Google',
                      // Если картинка из интернета, используем Image.network с рабочей ссылкой:
                      customImage: Image.network(
                        'https://developers.google.com/identity/images/g-logo.png',
                        height: 22,
                        width: 22,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.g_mobiledata,
                          size: 28,
                          color: Colors.blue,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      textColor: Colors.black87,
                      onTap: signInWithGoogle,
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      ),
                      child: const Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF723EB7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF723EB7), Color(0xFFB784C4)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF723EB7).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        )
            : Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    IconData? icon,
    Widget? customIcon,
    Widget? customImage,
    Color? iconColor,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (customImage != null) ...[
              customImage,
              const SizedBox(width: 12),
            ] else if (customIcon != null) ...[
              customIcon,
              const SizedBox(width: 12),
            ] else if (icon != null) ...[
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}