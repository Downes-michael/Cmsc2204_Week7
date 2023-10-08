import 'package:flutter/material.dart';

void main() => runApp(ItemListApp());

class ItemListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemListScreen(),
    );
  }
}

class Item {
  final int id;
  String name;
  String description;

  Item({required this.id, required this.name, required this.description});
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<Item> items = [
    Item(id: 1, name: "Wizard Hat", description: "Pointy"),
    Item(id: 2, name: "Dog", description: "Fluffy"),
    Item(id: 3, name: "Bike", description: "White"),
    Item(id: 4, name: "TV", description: "Samsung"),
    Item(id: 5, name: "Cup", description: "Orange"),
    Item(id: 6, name: "Clock", description: "Neon Analog"),
    Item(id: 7, name: "Chair", description: "Recliner"),
    Item(id: 8, name: "Water Bottle", description: "Hydroflask"),
    Item(id: 9, name: "Shoes", description: "Nike"),
    Item(id: 10, name: "Sunglasses", description: "Oakley"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downes Week 7"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Column(
                children: [
                  Text(
                    'Item id: ${item.id.toString()}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('Name: ${item.name}'),
                  Text('Desc.: ${item.description}'),
                  const Divider(),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("Edit"),
                      onPressed: () {
                        _editItem(item);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items.removeWhere((element) => element.id == item.id);
                        });
                      },
                      child: const Text('Delete'),
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _editItem(Item item) async {
    // Show a message to edit the item
    final editedItem = await showDialog<Item>(
      context: context,
      builder: (context) {
        TextEditingController nameController =
            TextEditingController(text: item.name);
        TextEditingController descriptionController =
            TextEditingController(text: item.description);

        return AlertDialog(
          title: Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                item.name = nameController.text;
                item.description = descriptionController.text;
                Navigator.of(context).pop(item);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (editedItem != null) {
      // Update item in the list
      setState(() {
        items[items.indexWhere((element) => element.id == editedItem.id)] =
            editedItem;
      });
    }
  }
}
