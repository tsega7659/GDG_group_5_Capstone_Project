import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedGender = 'All';
  List<String> selectedBrands = [];
  RangeValues priceRange = const RangeValues(16, 543);
  List<String> selectedColors = [];

  final List<String> genders = ['All', 'Men', 'Women'];
  final List<String> brands = [
    'Adidas',
    'Puma',
    'CR7',
    'Nike',
    'Yeezy',
    'Supreme',
  ];
  final List<String> colors = [
    'White',
    'Black',
    'Grey',
    'Yellow',
    'Red',
    'Green',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Filter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  genders.map((gender) {
                    return FilterChip(
                      selected: selectedGender == gender,
                      label: Text(gender),
                      onSelected: (selected) {
                        setState(() {
                          selectedGender = gender;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.deepPurple,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            selectedGender == gender
                                ? Colors.white
                                : Colors.black,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Brand',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  brands.map((brand) {
                    return FilterChip(
                      selected: selectedBrands.contains(brand),
                      label: Text(brand),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedBrands.add(brand);
                          } else {
                            selectedBrands.remove(brand);
                          }
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.deepPurple,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            selectedBrands.contains(brand)
                                ? Colors.white
                                : Colors.black,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${priceRange.start.round()}'),
                Text('\$${priceRange.end.round()}'),
              ],
            ),
            RangeSlider(
              values: priceRange,
              min: 16,
              max: 543,
              divisions: 100,
              activeColor: Colors.deepPurple,
              labels: RangeLabels(
                '\$${priceRange.start.round()}',
                '\$${priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  colors.map((color) {
                    return FilterChip(
                      selected: selectedColors.contains(color),
                      label: Text(color),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedColors.add(color);
                          } else {
                            selectedColors.remove(color);
                          }
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.deepPurple,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            selectedColors.contains(color)
                                ? Colors.white
                                : Colors.black,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Another option'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle another option tap
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Return filter data to previous screen
                  Navigator.pop(context, {
                    'gender': selectedGender,
                    'brands': selectedBrands,
                    'priceRange': priceRange,
                    'colors': selectedColors,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Apply Filter',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
