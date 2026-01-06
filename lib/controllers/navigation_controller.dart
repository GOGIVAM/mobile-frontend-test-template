import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/menu_item.dart';
import '../routes/app_routes.dart';
import '../pages/dashboard_screen.dart';
import '../pages/analytics_screen.dart';
import '../pages/reports_screen.dart';
import '../pages/products_screen.dart';
import '../pages/calendar_screen.dart';
import 'dart:html' as html;

class NavigationController extends GetxController {
  final RxString activeMenuItemId = 'dashboard'.obs;
  final RxMap<String, bool> expandedItems = <String, bool>{}.obs;

  // Définition de la structure du menu
  final List<MenuItem> menuItems = [
    MenuItem(
      id: 'dashboards',
      title: 'Dashboards',
      icon: Icons.home_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'dashboard',
          title: 'Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.dashboard,
          page: const DashboardScreen(),
        ),
        MenuItem(
          id: 'analytics',
          title: 'Analytics',
          icon: Icons.analytics_outlined,
          route: AppRoutes.analytics,
          page: const AnalyticsScreen(),
        ),
        MenuItem(
          id: 'reports',
          title: 'Reports',
          icon: Icons.description_outlined,
          route: AppRoutes.reports,
          page: const ReportsScreen(),
        ),
      ],
    ),
    MenuItem(
      id: 'product',
      title: 'Product',
      icon: Icons.inventory_2_outlined,
      route: AppRoutes.products,
      page: const ProductsScreen(),
    ),
    MenuItem(
      id: 'widgets',
      title: 'Widgets',
      icon: Icons.widgets_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'widget1',
          title: 'Widget 1',
          icon: Icons.widgets,
        ),
        MenuItem(
          id: 'widget2',
          title: 'Widget 2',
          icon: Icons.widgets,
        ),
      ],
    ),
    MenuItem(
      id: 'ui_elements',
      title: 'UI Elements',
      icon: Icons.layers_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'ui1',
          title: 'Element 1',
          icon: Icons.layers,
        ),
        MenuItem(
          id: 'ui2',
          title: 'Element 2',
          icon: Icons.layers,
        ),
      ],
    ),
    MenuItem(
      id: 'pages',
      title: 'Pages',
      icon: Icons.article_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'page1',
          title: 'Page 1',
          icon: Icons.article,
        ),
        MenuItem(
          id: 'page2',
          title: 'Page 2',
          icon: Icons.article,
        ),
      ],
    ),
    MenuItem(
      id: 'calendar',
      title: 'Calendar',
      icon: Icons.calendar_month_outlined,
      route: AppRoutes.calendar,
      page: const CalendarScreen(),
    ),
    MenuItem(
      id: 'forms',
      title: 'Forms',
      icon: Icons.dashboard_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'form1',
          title: 'Form 1',
          icon: Icons.edit,
        ),
        MenuItem(
          id: 'form2',
          title: 'Form 2',
          icon: Icons.edit,
        ),
      ],
    ),
    MenuItem(
      id: 'tables',
      title: 'Tables',
      icon: Icons.table_chart_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'table1',
          title: 'Table 1',
          icon: Icons.table_chart,
        ),
        MenuItem(
          id: 'table2',
          title: 'Table 2',
          icon: Icons.table_chart,
        ),
      ],
    ),
    MenuItem(
      id: 'graphs_maps',
      title: 'Graphs & Maps',
      icon: Icons.pie_chart_outline,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'graph1',
          title: 'Graph 1',
          icon: Icons.bar_chart,
        ),
        MenuItem(
          id: 'map1',
          title: 'Map 1',
          icon: Icons.map,
        ),
      ],
    ),
    MenuItem(
      id: 'layouts',
      title: 'Layouts',
      icon: Icons.view_quilt_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'layout1',
          title: 'Layout 1',
          icon: Icons.view_quilt,
        ),
        MenuItem(
          id: 'layout2',
          title: 'Layout 2',
          icon: Icons.view_quilt,
        ),
      ],
    ),
    MenuItem(
      id: 'authentication',
      title: 'Authentication',
      icon: Icons.security_outlined,
      isExpandable: true,
      subItems: [
        MenuItem(
          id: 'login',
          title: 'Login',
          icon: Icons.login,
        ),
        MenuItem(
          id: 'register',
          title: 'Register',
          icon: Icons.person_add,
        ),
      ],
    ),
    MenuItem(
      id: 'link',
      title: 'Link',
      icon: Icons.link_outlined,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Ouvrir le menu Dashboards par défaut
    expandedItems['dashboards'] = true;
    // Synchroniser avec la route actuelle SEULEMENT au démarrage
    _syncWithCurrentRoute();
  }

  void _syncWithCurrentRoute() {
    // Attendre que Get soit prêt
    Future.delayed(const Duration(milliseconds: 200), () {
      if (Get.isRegistered<NavigationController>()) {
        final currentRoute = Get.currentRoute;
        updateActiveMenuItemFromRoute(currentRoute);
      }
    });
  }

  void updateActiveMenuItemFromRoute(String route) {
    if(kDebugMode){
      print('updateActiveMenuItemFromRoute appelé avec route: $route');
    }
    
    // Trouver l'item correspondant à la route actuelle
    MenuItem? item = _findMenuItemByRoute(route);
    
    if (item != null) {
      if(kDebugMode){
        print('Item trouvé pour route: ${item.id}');
      }
      activeMenuItemId.value = item.id;
      
      // Si c'est un sous-item, ouvrir le parent
      MenuItem? parent = _findParentMenuItem(item.id);
      if (parent != null && parent.isExpandable) {
        expandedItems[parent.id] = true;
      }
    } else if (route == '/' || route.isEmpty) {
      if(kDebugMode){
        print('Route vide ou /, utiliser dashboard par défaut');
      }
      // Route par défaut
      activeMenuItemId.value = 'dashboard';
    } else {
      if(kDebugMode){
        print('Aucun item trouvé pour route: $route');
      }
      
    }
  }

  MenuItem? _findMenuItemByRoute(String route) {
    for (var item in menuItems) {
      if (item.route == route) return item;
      if (item.hasSubItems) {
        for (var subItem in item.subItems!) {
          if (subItem.route == route) return subItem;
        }
      }
    }
    return null;
  }

  // Route active (sans utiliser Get.toNamed)
  final RxString currentRoute = AppRoutes.dashboard.obs;
  
  void navigateToMenuItem(String menuItemId) {
    // Trouver l'item dans la structure
    MenuItem? item = _findMenuItemById(menuItemId);
    
    if(kDebugMode){
      print('NavigateToMenuItem - menuItemId: $menuItemId, route: ${item?.route}');
    }
    
    if (item != null && item.hasRoute) {
      // Vérifier si on est déjà sur cette route
      if (currentRoute.value == item.route) {
        
        activeMenuItemId.value = menuItemId;
        return;
      }
      
      activeMenuItemId.value = menuItemId;
      
      // Si c'est un sous-item, ouvrir le parent
      MenuItem? parent = _findParentMenuItem(menuItemId);
      if (parent != null && parent.isExpandable) {
        expandedItems[parent.id] = true;
      }
      
      // Changer la route active (pas de navigation GetX)
      if(kDebugMode){
        print('Changement de route vers: ${item.route}');
      }
      currentRoute.value = item.route!;
      
      // Forcer le changement d'URL dans le navigateur pour le web
      html.window.history.pushState(null, '', '#${item.route}');
      
      if(kDebugMode){
        print('Route changée vers: ${currentRoute.value}');
      }
      if(kDebugMode){
        print('URL changée vers: ${html.window.location.href}');
      }
    }
  }
  
  // Obtenir la page à afficher selon la route actuelle
  Widget getCurrentPage() {
    MenuItem? item = _findMenuItemByRoute(currentRoute.value);
    if (item != null && item.hasPage) {
      return item.page!;
    }
    // Par défaut, retourner le dashboard
    return  DashboardScreen();
  }

  void toggleExpanded(String menuItemId) {
    if (expandedItems.containsKey(menuItemId)) {
      expandedItems[menuItemId] = !expandedItems[menuItemId]!;
    } else {
      expandedItems[menuItemId] = true;
    }
  }

  bool isExpanded(String menuItemId) {
    return expandedItems[menuItemId] ?? false;
  }

  bool isActive(String menuItemId) {
    return activeMenuItemId.value == menuItemId;
  }

  bool isActiveOrChildActive(String menuItemId) {
    if (isActive(menuItemId)) return true;
    
    MenuItem? item = _findMenuItemById(menuItemId);
    if (item != null && item.hasSubItems) {
      for (var subItem in item.subItems!) {
        if (isActive(subItem.id)) return true;
        if (isActiveOrChildActive(subItem.id)) return true;
      }
    }
    
    return false;
  }

  MenuItem? _findMenuItemById(String id) {
    for (var item in menuItems) {
      if (item.id == id) return item;
      if (item.hasSubItems) {
        for (var subItem in item.subItems!) {
          if (subItem.id == id) return subItem;
        }
      }
    }
    return null;
  }

  MenuItem? _findParentMenuItem(String id) {
    for (var item in menuItems) {
      if (item.hasSubItems) {
        for (var subItem in item.subItems!) {
          if (subItem.id == id) return item;
        }
      }
    }
    return null;
  }
}

