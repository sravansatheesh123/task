import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'ProductDetailScreen.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) {
        model.fetchProductsAndCategories();
      },
      viewModelBuilder: () {
        return HomeViewModel();
      },
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: Text('Home')),
          body: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Categories"),
              ),
              Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.categories.length,
                    itemBuilder: (context, index) {
                      final category = viewModel.categories[index];
                      return Container(
                        color: Colors.black12,
                        height: 100,
                        width: 100,
                        child: Center(child: Text(category['Cat_name'])),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Top Products"),
              ),
              Expanded(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: viewModel.products.length,
                      itemBuilder: (context, index) {
                        final product = viewModel.products[index];
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(product['part_image'],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    product['description'] ?? "No Description",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Price: ₹${product['price']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                    "Rating: ${product['product_rating']}",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        );
      },
    );
  }
}
