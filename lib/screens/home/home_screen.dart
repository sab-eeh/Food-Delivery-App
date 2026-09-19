import 'package:flutter/material.dart';
import '../../models/food_model.dart';
import '../../services/food_service.dart';
import '../../widgets/food_card.dart';
import '../food_detail/food_detail_screen.dart';
import '../../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<FoodModel> allFoods = [];

  List<FoodModel> filteredFoods = [];

  bool isLoading = true;

  String userName = "User";

  @override
  void initState() {
    super.initState();
    loadFoods();
    loadUserData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    try {
      final data = await FirestoreService().getCurrentUserData();

      if (data != null) {
        setState(() {
          userName = data['name'];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadFoods() async {
    try {
      final foods = await FoodService().getFoods();

      if (!mounted) return;

      setState(() {
        allFoods = foods;
        filteredFoods = foods;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      debugPrint(e.toString());
    }
  }

  void searchFood(String query) {
    setState(() {
      filteredFoods = allFoods.where((food) {
        return food.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Widget categoryChip(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 10),

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.orange.shade100,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: RefreshIndicator(
        onRefresh: loadFoods,

        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Hello, $userName",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "What would you like to eat today?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const CircleAvatar(radius: 24, child: Icon(Icons.person)),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// SEARCH
                  TextField(
                    controller: searchController,

                    onChanged: searchFood,

                    decoration: InputDecoration(
                      hintText: "Search food...",

                      prefixIcon: const Icon(Icons.search),

                      filled: true,

                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// CATEGORIES
                  const Text(
                    "Categories",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 45,

                    child: ListView(
                      scrollDirection: Axis.horizontal,

                      children: [
                        categoryChip("Burger"),

                        categoryChip("Pizza"),

                        categoryChip("Drinks"),

                        categoryChip("Dessert"),

                        categoryChip("Sandwich"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// OFFER BANNER
                  Container(
                    width: double.infinity,

                    height: 150,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [
                          Text(
                            "50% OFF",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "On your first order",

                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// POPULAR FOODS
                  const Text(
                    "Popular Foods",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  filteredFoods.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(30),

                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 60,
                                  color: Colors.grey,
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "No Food Found",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 270,

                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,

                            itemCount: filteredFoods.length,

                            itemBuilder: (context, index) {
                              final food = filteredFoods[index];

                              return FoodCard(
                                food: food,

                                onTap: () {
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder: (_) =>
                                          FoodDetailScreen(food: food),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
