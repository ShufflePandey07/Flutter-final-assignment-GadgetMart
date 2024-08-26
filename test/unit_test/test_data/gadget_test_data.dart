import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';

class GadgetTestData {
  GadgetTestData._();

  static List<GadgetEntity> getGadgetTestData() {
    List<GadgetEntity> lstGadgets = [
      const GadgetEntity(
        id: '66867ea3227c633c73a35925',
        productName: 'Iphone',
        productCategory: 'mobile',
        productDescription: 'Latest ',
        productPrice: 100000,
        productImage: '1720090275647-iphonex.png',
      ),
      const GadgetEntity(
        id: '668f8a588287b80f0d62308e',
        productName: 'Airpods',
        productCategory: 'accessories',
        productDescription: 'Latest ',
        productPrice: 30,
        productImage: '1720683096378-airpods.png',
      ),
      const GadgetEntity(
        id: '668f8a588287b80f0d62308e',
        productName: 'Macbook',
        productCategory: 'laptop',
        productDescription: 'Latest ',
        productPrice: 1000,
        productImage: '1720683096378-macbook.png',
      ),
      const GadgetEntity(
        id: '668f8a588287b80f0d62308f',
        productName: 'Macbook',
        productCategory: 'laptop',
        productDescription: 'Latest ',
        productPrice: 1000,
        productImage: '1720683096378-macbook.png',
      ),
    ];

    return lstGadgets;
  }
}
