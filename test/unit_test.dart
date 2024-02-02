import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yoshua_ui_test/api/endpoint/product/get_product_response.dart';
import 'package:yoshua_ui_test/api/endpoint/product/get_product_response_data_rating.dart';

import 'unit_test_mocks.dart';

void main(){
  group('Testing Fake API', (){
    test('Mendapat data product dari API', () async {
      final mockApiService = MockApiService();

      when(mockApiService.getProductFake()).thenAnswer((_) async {
        var prod = ProductResponse(id: 1, title: 'tas', price: 11.02, description: 'Tas biasa', category: 'tas', image: '', rating: ProductRating(count: 2, rate: 3.9));
        return prod;
      });
      final product = await mockApiService.getProductFake();
      expect(product.title, 'tas');
      expect(product.price, 11.02);
      expect(product.id, 1);
      expect(product.description, 'Tas biasa');
      expect(product.category, 'tas');
    });

    test('throw error on api hit', () async {
      final mockApiService = MockApiService();
      when(mockApiService.getProductFake())
          .thenThrow(Exception('failed to get data'));
      expect(() async => await mockApiService.getProductFake(), throwsException);
    });
  });
}