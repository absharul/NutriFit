import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrifit/Hive/Box/boxes.dart';
import 'package:nutrifit/Screens/about_us_screen.dart';
import 'package:nutrifit/Screens/check_screen.dart';
import 'package:nutrifit/Screens/meal_screen.dart';
import 'package:nutrifit/Screens/progress_screen.dart';
import 'package:nutrifit/Screens/workout_screen.dart';
import '../Hive/UserNutrition/user_nutrition.dart';
import '../Widgets/User_Form/add_meal_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedBottomNavIndex = 0; // Tracks BottomNavBar selection
  late TabController _tabController;

  final List<Widget> _bottomNavScreens = [
    const HomeScreen(),  // This will be where the TabBar is
    const WorkoutScreen(),
    MealSection(),
    const AboutUsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 Tabs for HomeScreen
  }

  void _showAddMealDialog() {
    UserNutrition currentUser = nutritionBox.getAt(0);
    showDialog(
      context: context,
      builder: (context) {
        return AddMealDialog(userNutrition: currentUser,);
      },
    );
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedBottomNavIndex == 0
          ? AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "NutriFit",
          style: GoogleFonts.inter(
              fontSize: 40,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3.0,
          indicatorColor: Colors.yellowAccent,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          tabs: const [
            Tab(text: 'Progress'), // First Tab
            Tab(text: 'Calculator'), // Second Tab
          ],
        ),
      )
          : null, // No AppBar when not on HomeScreen
      body: _selectedBottomNavIndex == 0
          ? TabBarView(
        controller: _tabController,
        children: const [
          ProgressScreen(),
          CheckScreen(),
          // MealSection(),
        ],
      )
          : _bottomNavScreens[_selectedBottomNavIndex], // Show other screens based on BottomNav selection
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMealDialog,
        shape: const CircleBorder(),
        backgroundColor: Colors.yellowAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            _buildBottomNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
            ),
            // Workout Button
            _buildBottomNavItem(
              icon: Icons.sports_gymnastics_outlined,
              label: 'Workout',
              index: 1,
            ),
            const SizedBox(width: 48), // Space for the FAB
            // Progress Button
            _buildBottomNavItem(
              icon: Icons.fastfood,
              label: 'Meals',
              index: 2,
            ),
            // Profile Button
            _buildBottomNavItem(
              icon: Icons.person,
              label: 'About us',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: 1.0,
        end: _selectedBottomNavIndex == index ? 1.2 : 1.0,
      ),
      duration: const Duration(milliseconds: 150),
      builder: (context, scale, child) {
        return IconButton(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            transform: Matrix4.identity()..scale(scale),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: _selectedBottomNavIndex == index
                      ? Colors.yellowAccent
                      : Colors.white,
                  size: 20,
                ),
                const SizedBox(height: 2.0),
                Text(
                  label,
                  style: TextStyle(
                    color: _selectedBottomNavIndex == index
                        ? Colors.yellowAccent
                        : Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () => _onBottomNavItemTapped(index),
        );
      },
    );
  }
}
