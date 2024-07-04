import 'dart:io';



class MenuItem {
  String name;
  int price;
  String category;

  MenuItem({required this.name, required this.price, required this.category});

  @override
  String toString() {
    return '$name ($category) - $price THB';
  }
}

class Order {
  String orderId;
  int tableNumber;
  List<MenuItem> items = [];
  bool isCompleted = false;

  Order({required this.orderId, required this.tableNumber});

  void addItem(MenuItem item) {
    items.add(item);
  }

  void removeItem(MenuItem item) {
    items.remove(item);
  }

  void completeOrder() {
    isCompleted = true;
  }

  @override
  String toString() {
    return 'Order $orderId at table $tableNumber - ${items.join(', ')}';
  }
}

class Restaurant {
  List<MenuItem> menu = [];
  List<Order> orders = [];
  Map<int, bool> tables = {};

  void addMenuItem(MenuItem item) {
    menu.add(item);
  }

  void removeMenuItem(MenuItem item) {
    menu.remove(item);
  }

  void placeOrder(Order order) {
    orders.add(order);
  }

  void completeOrder(String orderId) {
    for (var order in orders) {
      if (order.orderId == orderId) {
        order.completeOrder();
        break;
      }
    }
  }

  MenuItem? getMenuItem(String name) {
    for (var item in menu) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  Order? getOrder(String orderId) {
    for (var order in orders) {
      if (order.orderId == orderId) {
        return order;
      }
    }
    return null;
  }

  void displayMenu() {
    print('Menu:');
    for (var item in menu) {
      print(item);
    }
  }

  void displayOrders() {
    print('Orders:');
    for (var order in orders) {
      print(order);
    }
  }
}

void main() async {
  var restaurant = Restaurant();

  
  var menuItem1 = MenuItem(name: 'Pad Thai', price: 150, category: 'Main Course');
  var menuItem2 = MenuItem(name: 'Green Tea', price: 50, category: 'Beverage');
  var menuItem3 = MenuItem(name: 'Mango Sticky Rice', price: 100, category: 'Dessert');
  restaurant.addMenuItem(menuItem1);
  restaurant.addMenuItem(menuItem2);
  restaurant.addMenuItem(menuItem3);

 
  while (true) {
    print('Welcome to the restaurant system!');
    print('1. Add menu item');
    print('2. Remove menu item');
    print('3. Place order');
    print('4. Complete order');
    print('5. Display menu');
    print('6. Display orders');
    print('7. Exit');

    var choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        print('Enter menu item name:');
        var name = stdin.readLineSync() ?? '';
        print('Enter menu item price:');
        var price = int.parse(stdin.readLineSync() ?? '');
        print('Enter menu item category:');
        var category = stdin.readLineSync() ?? '';
        var newMenuItem = MenuItem(name: name, price: price, category: category);
        restaurant.addMenuItem(newMenuItem);
        print('');
        break;
      case '2':
        print('Enter menu item name to remove:');
        var removeName = stdin.readLineSync() ?? '';
        var removeItem = restaurant.getMenuItem(removeName);
        if (removeItem != null) {
          restaurant.removeMenuItem(removeItem);
        } else {
          print('Menu item not found!');
        }
        print('');
        break;
      case '3':
        print('Enter order ID:');
        var orderId = stdin.readLineSync() ?? '';
        print('Enter table number:');
        var tableNumber = int.parse(stdin.readLineSync() ?? '');
        var order = Order(orderId: orderId, tableNumber: tableNumber);
        print('Enter menu item names to add:');
        var itemNames = stdin.readLineSync() ?? '';
        for (var itemName in itemNames.split(',')) {
          var item = restaurant.getMenuItem(itemName.trim());
          if (item != null) {
            order.addItem(item);
          } else {
            print('Menu item not found!');
          }
        }
        restaurant.placeOrder(order);
        print('');
        break;
      case '4':
        print('Enter order ID to complete:');
        var completeOrderId = stdin.readLineSync() ?? '';
        restaurant.completeOrder(completeOrderId);
        print('');
        break;
      case '5':
        restaurant.displayMenu();
        print('');
        break;
      case '6':
        restaurant.displayOrders();
    }
  }
}