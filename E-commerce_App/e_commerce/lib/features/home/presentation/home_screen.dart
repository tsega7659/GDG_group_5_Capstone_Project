import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), 
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://picsum.photos/150'), // Placeholder image
                ),
                const SizedBox(width: 12.0),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    Text(
                      'John William',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.black87),
                  onPressed: () {
                    // TODO: Implement notification action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar Section (Profile, Greeting, Notification)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            // Banner Carousel Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                height: 200.0,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.deepPurple.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Get Winter Discount',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    '20% Off',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'For Children',
                                    style: TextStyle(fontSize: 16, color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                              'https://picsum.photos/350/200',
                              height: 180,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Featured Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement see all action
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0, 
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProductCard(
                          'Watch',
                          '\$40',
                          'https://picsum.photos/200/200',
                        ),
                        _buildProductCard(
                          'Nike Shoes',
                          '\$430',
                          'https://picsum.photos/201/200',
                        ),
                        _buildProductCard(
                          'Airpods',
                          '\$333',
                          'https://picsum.photos/202/200',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Most Popular Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Most Popular',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement see all action
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0, 
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProductCard(
                          'LG TV',
                          '\$330',
                          'https://picsum.photos/203/200',
                        ),
                        _buildProductCard(
                          'Hoodie',
                          '\$50',
                          'https://picsum.photos/204/200',
                        ),
                        _buildProductCard(
                          'Jacket',
                          '\$400',
                          'https://picsum.photos/205/200',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String imageUrl) {
    return Container(
      width: 180.0, 
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight:Radius.circular(12.0),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  price,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
    );
  }
}