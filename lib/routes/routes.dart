class JRoutes {
  static const firstScreen = '/';
  static const secondScreen = '/second-screen';
  static const secondScreenWithUID = '/second-screen/:userId';

  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';
  static const returns = '/returns';
  
  static const coupons = '/coupons';
  static const settings = '/settings';
  static const profile = '/profile';
  static const logout = '/logout';

  static const responsiveDesignScreen = '/responsiveDesignScreen';

  static List sidebarMenuItems = [
    dashboard,
    media,
    categories,
    banners,
    products,
    customers,
    returns,
    settings,
    profile,
    logout,
  ];
}
