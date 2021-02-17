import '../screens/pizza_detail_screen.dart';
import '../screens/pizza_edit_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/admin_pizza_screen.dart';
import '../screens/admin_edit_pizzas_screen.dart';
import '../screens/personal_info_screen.dart';
import '../screens/address_screen.dart';
import '../screens/edit_address_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/about_us_screen.dart';
import '../screens/admin_sale_screen.dart';

class Routes {
  final routers = {
    PizzaDetailScreen.routeName: (ctx) => PizzaDetailScreen(),
    PizzaEditScreen.routeName: (ctx) => PizzaEditScreen(),
    CartScreen.routeName: (ctx) => CartScreen(),
    OrdersScreen.routeName: (ctx) => OrdersScreen(),
    AdminPizzaScreen.routeName: (ctx) => AdminPizzaScreen(),
    AdminEditPizzaScreen.routeName: (ctx) => AdminEditPizzaScreen(),
    PersonalInfoScreen.routeName: (ctx) => PersonalInfoScreen(),
    AddressScreen.routeName: (ctx) => AddressScreen(),
    EditAddressScreen.routeName: (ctx) => EditAddressScreen(),
    ContactScreen.routeName: (ctx) => ContactScreen(),
    AboutUsScreen.routName: (ctx) => AboutUsScreen(),
    AdminSaleScreen.routeName: (ctx) => AdminSaleScreen(),
  };
}
