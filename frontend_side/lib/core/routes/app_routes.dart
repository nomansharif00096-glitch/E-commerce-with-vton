enum AppRoutes {
  search('/search-view'),
  favorites('/favorites-view'),
  productDetail('/product-detail-view'),
  productsBasedOnCategory('/product-category-view'),
  profile('/profile-view'),
  cartView('/cart-view'),
  homeView('/home-view'),
  auth('/auth-view');

  const AppRoutes(this.route);
  final String route;
}
