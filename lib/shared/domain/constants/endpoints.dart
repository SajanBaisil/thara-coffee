// final String _baseUrl = 'https://erp-stage.tharacoffee.com';
final String _baseUrl = 'https://maretek.addonez.com';
const String _api = '/api';
const String _view = '/view';
const String _product = '/product';
const String _get = '/get';
String endpoint = '$_baseUrl$_api';
String viewEndpoint = '$_baseUrl$_view';
String productEndpoint = '$_baseUrl$_product';
String getEndpoint = '$_baseUrl$_get';

class Endpoints {
  static final String customer = '$endpoint/customer';
  static final String company = '$viewEndpoint/company';
  static final String category = '$productEndpoint/category';
  static final String product = '$getEndpoint/products';
  static final String singleProduct = '$viewEndpoint/product';
}
