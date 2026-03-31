import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_state.dart';
import 'package:food_hub/shared/app_loading.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:food_hub/core/helper/cache_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = getIt<AuthCubit>();
    authCubit.loadCurrentUser();
  }

  Future<void> _showLogoutDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child:  Text("Logout",style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _logout();
    }
  }

  void _logout() async {
    await authCubit.logout();
    await CacheHelper.clearAll();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Widget _userTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color iconBgColor = Colors.blueAccent,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconBgColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: AppLoading());
          }
          if (state is AuthSuccess) {
            final user = state.user;
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  //  Name Tile
                  _userTile(
                    icon: Icons.person,
                    title: "Name",
                    subtitle: user.name,
                    iconBgColor: AppColors.primary,
                  ),
                  //  Email Tile
                  _userTile(
                    icon: Icons.email,
                    title: "Email",
                    subtitle: user.email,
                    iconBgColor: Colors.orangeAccent,
                  ),
                  const Spacer(),
                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: _showLogoutDialog,
                      icon:  Icon(Icons.logout,color: Colors.black,),
                      label:  Text("Logout",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300
                      ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is AuthError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}