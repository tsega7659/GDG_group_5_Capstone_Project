import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter Page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Arial',
      ),
      home: FilterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _priceStart = 16;
  double _priceEnd = 543;

  String selectedGender = 'All';
  List<String> selectedBrands = ['Puma', 'Nike', 'Supreme'];
  List<String> selectedColors = ['Black', 'Yellow', 'Green'];

  final List<String> genders = ['All', 'Men', 'Women'];
  final List<String> brands = ['Adidas', 'Puma', 'CR7', 'Nike', 'Yeezy', 'Supreme'];
  final List<String> colors = ['White', 'Black', 'Grey', 'Yellow', 'Red', 'Green'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Filter',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Gender'),
            _buildChoiceChips(genders, selectedGender, (val) {
              setState(() {
                selectedGender = val;
              });
            }),
            SizedBox(height: 20),
            _buildSectionTitle('Brand'),
            _buildMultiSelectChips(brands, selectedBrands, (val) {
              setState(() {
                if (selectedBrands.contains(val)) {
                  selectedBrands.remove(val);
                } else {
                  selectedBrands.add(val);
                }
              });
            }),
            SizedBox(height: 20),
            _buildSectionTitle('Price Range'),
            RangeSlider(
              min: 16,
              max: 543,
              values: RangeValues(_priceStart, _priceEnd),
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey[300],
              onChanged: (RangeValues values) {
                setState(() {
                  _priceStart = values.start;
                  _priceEnd = values.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${_priceStart.toInt()}'),
                Text('\$${_priceEnd.toInt()}'),
              ],
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Color'),
            _buildMultiSelectChips(colors, selectedColors, (val) {
              setState(() {
                if (selectedColors.contains(val)) {
                  selectedColors.remove(val);
                } else {
                  selectedColors.add(val);
                }
              });
            }),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Another option',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to another page or show options
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Apply filter action
                print('Filters applied!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Apply Filter',
                style: TextStyle(fontSize: 18, color: Colors.white ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildChoiceChips(List<String> options, String selectedOption, Function(String) onSelected) {
    return Wrap(
      spacing: 10,
      children: options.map((option) {
        final isSelected = selectedOption == option;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
          selectedColor: Colors.deepPurple,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectChips(List<String> options, List<String> selectedOptions, Function(String) onSelected) {
    return Wrap(
      spacing: 10,
      children: options.map((option) {
        final isSelected = selectedOptions.contains(option);
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
          selectedColor: Colors.deepPurple,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
