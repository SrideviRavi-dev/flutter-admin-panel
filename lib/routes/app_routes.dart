import 'package:admin/features/authentication/screens/forgot_password/forgot_password.dart';
import 'package:admin/features/authentication/screens/login/login.dart';
import 'package:admin/features/authentication/screens/reset_password/reset_password.dart';
import 'package:admin/features/media/screens/media/media.dart';
import 'package:admin/features/personalization/screens/profile/profile.dart';
import 'package:admin/features/personalization/screens/settings/settings.dart';
import 'package:admin/features/shop/screens/banner/all_banner/banners.dart';
import 'package:admin/features/shop/screens/banner/create_banner/create_banner.dart';
import 'package:admin/features/shop/screens/banner/edit_banner/edit_banner.dart';
import 'package:admin/features/shop/screens/category/all_categories/categories.dart';
import 'package:admin/features/shop/screens/category/create_category/create_category.dart';
import 'package:admin/features/shop/screens/category/edit_category/edit_category.dart';
import 'package:admin/features/shop/screens/customer/all_customers/customers.dart';
import 'package:admin/features/shop/screens/customer/customer_details/customer_details.dart';
import 'package:admin/features/shop/screens/dashboard/dashboard.dart';
import 'package:admin/features/shop/screens/order/all_orders/orders.dart';
import 'package:admin/features/shop/screens/order/orders_detail/order_details.dart';
import 'package:admin/features/shop/screens/product/all_product/products.dart';
import 'package:admin/features/shop/screens/product/create_product/creates_products.dart';
import 'package:admin/features/shop/screens/product/edit_product/edit_products.dart';
import 'package:admin/features/shop/screens/return/return_request_screen.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/routes/routes_middleware.dart';
import 'package:get/get.dart';

class JAppRoute {
static final List<GetPage> pages = [
  GetPage(name: JRoutes.login, page: ()=>const LoginScreen()),
  GetPage(name: JRoutes.forgotPassword, page: ()=>ForgotPasswordScreen()),
  GetPage(name: JRoutes.resetPassword, page: ()=>ResetPasswordScreen()),
  GetPage(name: JRoutes.dashboard, page: ()=> DashboardScreen(),middlewares: [JRouteMiddleware()]),
  GetPage(name: JRoutes.media, page: ()=> MediaScreen(),middlewares: [JRouteMiddleware()]),
  //GetPage(name: JRoutes.responsiveDesignScreen, page: ()=>ResponsiveDesignScreen()),
  
  // Categories
  GetPage(name: JRoutes.categories, page: ()=> const CategoriesScreen(),middlewares: [JRouteMiddleware()]),
  GetPage(name: JRoutes.createCategory, page: ()=> const CreateCategoryScreen(),middlewares: [JRouteMiddleware()]),
  GetPage(name: JRoutes.editCategory, page: ()=> const EditCategoryScreen(),middlewares: [JRouteMiddleware()]),
  // Banner
  GetPage(name: JRoutes.banners, page:()=> const BannersScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.createBanner, page:()=> const CreateBannerScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.editBanner, page:()=> const EditBannerScreen(),middlewares:[JRouteMiddleware()] ),
  // Product
  GetPage(name: JRoutes.products, page:()=> const ProductsScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.createProduct, page:()=> const CreatesProductsScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.editProduct, page:()=> const EditProductsScreen(),middlewares:[JRouteMiddleware()] ),
  // Customers
  GetPage(name: JRoutes.customers, page:()=> const CustomersScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.customerDetails, page:()=> const CustomerDetailsScreen(),middlewares:[JRouteMiddleware()] ),
  // Orders
  GetPage(name: JRoutes.orders, page:()=> const OrdersScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.orderDetails, page:()=> const OrderDetailsScreen(),middlewares:[JRouteMiddleware()] ),
  GetPage(name: JRoutes.returns, page:()=>  ReturnRequestsScreen(),middlewares:[JRouteMiddleware()] ),
  // Settings
   GetPage(name: JRoutes.settings, page:()=> const SettingsScreen(),middlewares:[JRouteMiddleware()] ),
   GetPage(name: JRoutes.profile, page:()=> const ProfileScreen (),middlewares:[JRouteMiddleware()] ),
];
}