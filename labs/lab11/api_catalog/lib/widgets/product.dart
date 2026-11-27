import 'package:api_catalog/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      surfaceTintColor: Colors.white24,
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          children: [
            Image.network(
              product.thumbnail,
              fit: BoxFit.fitWidth,
              errorBuilder: (_, _, _) => Icon(Icons.image_not_supported),
            ),
            Text(product.title, style: textTheme.titleLarge),
            Text(product.description, style: textTheme.bodyMedium),
            SizedBox(height: 10.0),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsetsGeometry.all(10.0),
                child: Column(
                  mainAxisSize: .max,
                  children: [
                    Text("Dimensions", style: textTheme.titleMedium),
                    Wrap(
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(10.0),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Text("Width: ", style: textTheme.labelLarge),
                                Text(
                                  product.dimensions.width.toStringAsFixed(2),
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(10.0),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Text("Height: ", style: textTheme.labelLarge),
                                Text(
                                  product.dimensions.height.toStringAsFixed(2),
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(10.0),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Text("Depth: ", style: textTheme.labelLarge),
                                Text(
                                  product.dimensions.depth.toStringAsFixed(2),
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text("Reviews", style: textTheme.titleMedium),
                    for (final review in product.reviews)
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: .max,
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                spacing: 10.0,
                                children: [
                                  Text(
                                    review.reviewerName,
                                    style: textTheme.labelLarge,
                                  ),
                                  Text(
                                    "${"★" * review.rating}${"☆" * (5 - review.rating)} ${review.rating.toString()}",
                                    style: textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              if (review.comment != null) Text(review.comment!),
                              SizedBox(height: 20.0),
                              Text(review.date, style: textTheme.labelSmall),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
