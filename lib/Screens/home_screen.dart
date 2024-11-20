import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/User_Form/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "NutriFit",
          style: GoogleFonts.inter(
              fontSize: 40,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          indicatorWeight: 3.0,
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'), // First Tab
            Tab(text: 'Meals'), // Second Tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Column(
            children: [
              UserFormWidget(), // Content for Tab 1
            ],
          ),
          Center(
            child: Text('Tab 2 Content'), // Content for Tab 2
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for FAB
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 1.0,
                end: _selectedIndex == 0 ? 1.2 : 1.0,
              ),
              duration: const Duration(milliseconds: 150),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                      transform: Matrix4.identity()..scale(scale),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      )),
                  onPressed: () {
                    _onItemTapped(0); // Navigate to Home tab
                  },
                );
              },
            ),
            // Gymnastics Button
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 1.0,
                end: _selectedIndex == 1 ? 1.2 : 1.0,
              ),
              duration: const Duration(milliseconds: 150),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()..scale(scale),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.sports_gymnastics_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Workout',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    _onItemTapped(1); // Navigate to Meals tab
                  },
                );
              },
            ),
            const SizedBox(width: 48), // Space for the FAB

            // Chart Button
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 1.0,
                end: _selectedIndex == 2 ? 1.2 : 1.0,
              ),
              duration: const Duration(milliseconds: 150),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()..scale(scale),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Progress',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    _onItemTapped(
                        2); // Navigate to Chart tab (or any other tab)
                  },
                );
              },
            ),
            // Profile Button
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 1.0,
                end: _selectedIndex == 3 ? 1.2 : 1.0,
              ),
              duration: const Duration(milliseconds: 150),
              builder: (context, scale, child) {
                return IconButton(
                  icon: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                      transform: Matrix4.identity()..scale(scale),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      )),
                  onPressed: () {
                    _onItemTapped(
                        3); // Navigate to Profile tab (or any other tab)
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
