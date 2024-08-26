import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:final_assignment/features/gadgets/presentation/viewmodel/gadget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GadgetListView extends ConsumerStatefulWidget {
  const GadgetListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GadgetListViewState();
}

class _GadgetListViewState extends ConsumerState<GadgetListView> {
  late TextEditingController _searchController;
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  final Set<String> _favoriteClickedSet = {};

  final List<String> _carouselImages = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.png',
    'assets/images/carousel3.png',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gadgetState = ref.watch(gadgetViewModelProvider);
    final isTabletDevice = MediaQuery.of(context).size.width > 600;
    final ScrollController scrollController = ScrollController();

    List<GadgetEntity> filteredGadgets = gadgetState.gadgets.where((gadget) {
      return gadget.productName
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              if (scrollController.position.extentAfter == 0) {
                if (!gadgetState.hasReachedMax) {
                  ref.read(gadgetViewModelProvider.notifier).fetchGadgets();
                }
              }
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () {
              return ref.read(gadgetViewModelProvider.notifier).resetState();
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCarousel(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSearchBar(),
                            const SizedBox(height: 24),
                            Text(
                              'Categories',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            _buildCategories(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTabletDevice ? 3 : 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _buildGadgetCard(filteredGadgets[index]),
                      childCount: filteredGadgets.length,
                    ),
                  ),
                ),
                if (gadgetState.isLoading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: _carouselImages.map((String imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search gadgets...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'image': 'assets/images/laptops.png', 'label': 'Laptops'},
      {'image': 'assets/images/accessories.png', 'label': 'Accessories'},
      {'image': 'assets/images/speakers.png', 'label': 'Speakers'},
      {'image': 'assets/images/mobile.png', 'label': 'Mobiles'},
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategoryIndex = index),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedCategoryIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        category['image'] as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      color: _selectedCategoryIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600],
                      fontWeight: FontWeight.bold,
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

  Widget _buildGadgetCard(GadgetEntity gadget) {
    const String baseUrl = 'http://10.0.2.2:5000/products/';

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                '$baseUrl${gadget.productImage}',
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gadget.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs${gadget.productPrice}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconButton(
                      Icons.shopping_cart,
                      Colors.blue,
                      () => _addToCart(gadget),
                    ),
                    _buildIconButton(
                      Icons.favorite,
                      _favoriteClickedSet.contains(gadget.id)
                          ? Colors.red
                          : Colors.grey,
                      () => _toggleFavorite(gadget),
                    ),
                    _buildIconButton(
                      Icons.remove_red_eye,
                      Colors.green,
                      () => _showGadgetDetails(context, gadget),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      padding: EdgeInsets.zero,
    );
  }

  void _toggleFavorite(GadgetEntity gadget) {
    setState(() {
      if (_favoriteClickedSet.contains(gadget.id)) {
        _favoriteClickedSet.remove(gadget.id);
        ref
            .read(gadgetViewModelProvider.notifier)
            .removeFromFavourites(gadget.id);
      } else {
        _favoriteClickedSet.add(gadget.id);
        final favouritesEntity = FavouritesEntity(gadgetEntity: gadget);
        ref
            .read(gadgetViewModelProvider.notifier)
            .addToFavourites(favouritesEntity);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_favoriteClickedSet.contains(gadget.id)
            ? '${gadget.productName} added to favorites'
            : '${gadget.productName} removed from favorites'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _addToCart(GadgetEntity gadget) {
    final cartEntity = CartEntity(
      gadgetEntity: gadget,
      quantity: 1,
      total: gadget.productPrice,
    );
    ref.read(gadgetViewModelProvider.notifier).addToCart(cartEntity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${gadget.productName} added to cart'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showGadgetDetails(BuildContext context, GadgetEntity gadget) {
    const String baseUrl = 'http://10.0.2.2:5000/products/';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      '$baseUrl${gadget.productImage}',
                      fit: BoxFit.cover,
                      height: 200,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gadget.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rs${gadget.productPrice}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          gadget.productDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
// import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
// import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
// import 'package:final_assignment/features/gadgets/presentation/viewmodel/gadget_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class GadgetListView extends ConsumerStatefulWidget {
//   const GadgetListView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _GadgetListViewState();
// }

// class _GadgetListViewState extends ConsumerState<GadgetListView> {
//   late TextEditingController _searchController;
//   int _selectedCategoryIndex = 0;
//   String _searchQuery = '';
//   final Set<String> _favoriteClickedSet = {};

//   final List<String> _carouselImages = [
//     'assets/images/carousel1.png',
//     'assets/images/carousel2.png',
//     'assets/images/carousel3.png',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var gadgetState = ref.watch(gadgetViewModelProvider);
//     final isTabletDevice = MediaQuery.of(context).size.width > 600;
//     final ScrollController scrollController = ScrollController();

//     List<GadgetEntity> filteredGadgets = gadgetState.gadgets.where((gadget) {
//       return gadget.productName
//           .toLowerCase()
//           .contains(_searchQuery.toLowerCase());
//     }).toList();

//     return Scaffold(
//       body: SafeArea(
//         child: NotificationListener<ScrollNotification>(
//           onNotification: (ScrollNotification notification) {
//             if (notification is ScrollUpdateNotification) {
//               if (scrollController.position.extentAfter == 0) {
//                 if (!gadgetState.hasReachedMax) {
//                   ref.read(gadgetViewModelProvider.notifier).fetchGadgets();
//                 }
//               }
//             }
//             return true;
//           },
//           child: RefreshIndicator(
//             onRefresh: () {
//               return ref.read(gadgetViewModelProvider.notifier).resetState();
//             },
//             child: CustomScrollView(
//               controller: scrollController,
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildCarousel(),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildSearchBar(),
//                             const SizedBox(height: 24),
//                             Text(
//                               'Categories',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge!
//                                   .copyWith(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             const SizedBox(height: 16),
//                             _buildCategories(isTabletDevice),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SliverPadding(
//                   padding: const EdgeInsets.all(16.0),
//                   sliver: SliverGrid(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: isTabletDevice ? 3 : 2,
//                       childAspectRatio: isTabletDevice ? 0.8 : 0.7,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) => _buildGadgetCard(
//                           filteredGadgets[index], isTabletDevice),
//                       childCount: filteredGadgets.length,
//                     ),
//                   ),
//                 ),
//                 if (gadgetState.isLoading)
//                   const SliverToBoxAdapter(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCarousel() {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 250.0,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         viewportFraction: 0.9,
//       ),
//       items: _carouselImages.map((String imageUrl) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 image: DecorationImage(
//                   image: AssetImage(imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSearchBar() {
//     return TextField(
//       controller: _searchController,
//       onChanged: (value) {
//         setState(() {
//           _searchQuery = value;
//         });
//       },
//       decoration: InputDecoration(
//         hintText: 'Search gadgets...',
//         prefixIcon: const Icon(Icons.search, color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//     );
//   }

//   Widget _buildCategories(bool isTablet) {
//     final categories = [
//       {'image': 'assets/images/laptops.png', 'label': 'Laptops'},
//       {'image': 'assets/images/accessories.png', 'label': 'Accessories'},
//       {'image': 'assets/images/speakers.png', 'label': 'Speakers'},
//       {'image': 'assets/images/mobile.png', 'label': 'Mobiles'},
//     ];

//     return SizedBox(
//       height: isTablet ? 160 : 130,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return Padding(
//             padding: EdgeInsets.only(right: isTablet ? 32.0 : 16.0),
//             child: GestureDetector(
//               onTap: () => setState(() => _selectedCategoryIndex = index),
//               child: Column(
//                 children: [
//                   Container(
//                     width: isTablet ? 100 : 80,
//                     height: isTablet ? 100 : 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: _selectedCategoryIndex == index
//                             ? Theme.of(context).primaryColor
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(18),
//                       child: Image.asset(
//                         category['image'] as String,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     category['label'] as String,
//                     style: TextStyle(
//                       color: _selectedCategoryIndex == index
//                           ? Theme.of(context).primaryColor
//                           : Colors.grey[600],
//                       fontWeight: FontWeight.bold,
//                       fontSize: isTablet ? 16 : 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildGadgetCard(GadgetEntity gadget, bool isTablet) {
//     const String baseUrl = 'http://10.0.2.2:5000/products/';

//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(15)),
//               child: Image.network(
//                 '$baseUrl${gadget.productImage}',
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 loadingBuilder: (context, child, progress) {
//                   if (progress == null) return child;
//                   return const Center(child: CircularProgressIndicator());
//                 },
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.error),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         gadget.productName,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: isTablet ? 16 : 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Rs${gadget.productPrice}',
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: isTablet ? 16 : 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildIconButton(
//                         Icons.shopping_cart,
//                         Colors.blue,
//                         () => _addToCart(gadget),
//                       ),
//                       _buildIconButton(
//                         Icons.favorite,
//                         _favoriteClickedSet.contains(gadget.id)
//                             ? Colors.red
//                             : Colors.grey,
//                         () => _toggleFavorite(gadget),
//                       ),
//                       _buildIconButton(
//                         Icons.remove_red_eye,
//                         Colors.green,
//                         () => _showGadgetDetails(context, gadget),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
//     return IconButton(
//       icon: Icon(icon, color: color),
//       onPressed: onPressed,
//       constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
//       padding: EdgeInsets.zero,
//     );
//   }

//   void _toggleFavorite(GadgetEntity gadget) {
//     setState(() {
//       if (_favoriteClickedSet.contains(gadget.id)) {
//         _favoriteClickedSet.remove(gadget.id);
//         ref
//             .read(gadgetViewModelProvider.notifier)
//             .removeFromFavourites(gadget.id);
//       } else {
//         _favoriteClickedSet.add(gadget.id);
//         final favouritesEntity = FavouritesEntity(gadgetEntity: gadget);
//         ref
//             .read(gadgetViewModelProvider.notifier)
//             .addToFavourites(favouritesEntity);
//       }
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(_favoriteClickedSet.contains(gadget.id)
//             ? '${gadget.productName} added to favorites'
//             : '${gadget.productName} removed from favorites'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _addToCart(GadgetEntity gadget) {
//     final cartEntity = CartEntity(
//       gadgetEntity: gadget,
//       quantity: 1,
//       total: gadget.productPrice,
//     );
//     ref.read(gadgetViewModelProvider.notifier).addToCart(cartEntity);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${gadget.productName} added to cart'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _showGadgetDetails(BuildContext context, GadgetEntity gadget) {
//     const String baseUrl = 'http://10.0.2.2:5000/products/';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 350),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(20)),
//                     child: Image.network(
//                       '$baseUrl${gadget.productImage}',
//                       fit: BoxFit.cover,
//                       height: 200,
//                       loadingBuilder: (context, child, progress) {
//                         if (progress == null) return child;
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.error),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           gadget.productName,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Rs${gadget.productPrice}',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           gadget.productDescription,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 24),
//                         ElevatedButton(
//                           onPressed: () => Navigator.of(context).pop(),
//                           child: const Text('Close'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
