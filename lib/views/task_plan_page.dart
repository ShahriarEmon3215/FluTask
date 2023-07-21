import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  List<Item> _items = [
    Item(
      name: 'Task One',
      totalPriceCents: 1299,
      uid: '1',
      imageProvider: NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg'),
    ),
    Item(
      name: 'Task Two',
      totalPriceCents: 799,
      uid: '2',
      imageProvider: NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg'),
    ),
    Item(
      name: 'Task Three',
      totalPriceCents: 1499,
      uid: '3',
      imageProvider: NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg'),
    ),
  ];

  List<Customer> _people = [
    Customer(
      name: 'Shahriar Emon',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
    ),
    Customer(
      name: 'Adman Morshed',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg'),
    ),
    Customer(
      name: 'Shiblee Shahriar',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
    ),
  ];

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {
    setState(() {
      customer.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorThree,
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios)),
      title: Text(
        'Task Assign',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 25,
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: AppColors.colorFour,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              _people = [
                Customer(
                  name: 'Shahriar Emon',
                  imageProvider: const NetworkImage('https://flutter'
                      '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
                ),
              ];
              setState(() {});
            },
            icon: Icon(Icons.settings_ethernet)),
      ],
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildMenuList(),
              ),
              Container(height: 300, child: _buildPeopleRow()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12.0,
        );
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildMenuItem(
          item: item,
        );
      },
    );
  }

  Widget _buildMenuItem({
    required Item item,
  }) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        title: item.name,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 20.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _people.map(_buildPersonWithDropZone).toList(),
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: DragTarget<Item>(
        builder: (context, candidateItems, rejectedItems) {
          return CustomerCart(
            hasItems: customer.items.isNotEmpty,
            highlighted: candidateItems.isNotEmpty,
            customer: customer,
          );
        },
        onAccept: (item) {
          _itemDroppedOnCustomerCart(
            item: item,
            customer: customer,
          );
        },
      ),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(22.0),
        color: highlighted ? AppColors.colorOne : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Text(
                  customer.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight:
                            hasItems ? FontWeight.normal : FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Visibility(
                    visible: hasItems,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: ListView.builder(
                      itemCount: customer.items.length,
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.colorTwo,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              customer.items[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      color: AppColors.green,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 35,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 30.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.title,
  });

  final GlobalKey dragKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: Container(
        key: dragKey,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.totalPriceCents,
    required this.name,
    required this.uid,
    required this.imageProvider,
  });
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  String get formattedTotalItemPrice =>
      '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
}

class Customer {
  Customer({
    required this.name,
    required this.imageProvider,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
