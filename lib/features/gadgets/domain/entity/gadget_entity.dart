

import 'package:equatable/equatable.dart';

class GadgetEntity extends Equatable {


  final String id;
  final String productName;
  final String productCategory;
  final String productDescription;
  final double productPrice;
  final String productImage;
  
  const GadgetEntity({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
  });

  @override
  List<Object> get props => [
    id,
    productName,
    productCategory,
    productDescription,
    productPrice,
    productImage,
  ];


}