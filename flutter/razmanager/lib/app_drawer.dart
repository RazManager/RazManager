import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'public/event/public_event.dart';
import 'public/event_settings/public_event_settings.detail.dart';
import 'public/heat/public_heat.dart';
import 'public/home/home.dart';
import 'public/profile/profile.detail.dart';
import 'public/race/public_race.dart';
import 'public/settings/settings.detail.dart';
import 'public/sign_in/sign_in_page.dart';
import 'public/sign_up/sign_up_page.dart';
import 'tenant_admin/car/tenant_admin_car.detail.dart';
import 'tenant_admin/car/tenant_admin_car.list.dart';
import 'tenant_admin/car_tag/tenant_admin_car_tag.detail.dart';
import 'tenant_admin/car_tag/tenant_admin_car_tag.list.dart';
import 'tenant_admin/device/tenant_admin_device.add.dart';
import 'tenant_admin/device/tenant_admin_device_io_simulated.detail.dart';
import 'tenant_admin/device/tenant_admin_device.list.dart';
import 'tenant_admin/device/tenant_admin_device_io_simulated.view.dart';
import 'tenant_admin/event/tenant_admin_event.detail.dart';
import 'tenant_admin/event/tenant_admin_event.list.dart';
import 'tenant_admin/race/tenant_admin_race.detail.dart';
import 'tenant_admin/race/tenant_admin_race.list.dart';
import 'tenant_admin/tenant/tenant_admin_tenant.detail.dart';
import 'tenant_admin/track/tenant_admin_track.detail.dart';
import 'tenant_admin/track/tenant_admin_track.list.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const Home()),
    ),
    GoRoute(
      path: '/public/sign-in',
      pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: SignIn(refresh: state.extra as AsyncCallback)),
    ),
    GoRoute(
      path: '/public/sign-up',
      pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: SignUp(refresh: state.extra as AsyncCallback)),
    ),
    GoRoute(
      path: '/public/events/:id',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: PublicEvent(id: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/public/races/:id',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: PublicRace(id: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/public/heats/:id',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: PublicHeat(id: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/public/event-settings',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: PublicEventSettingsDetail(),
      ),
    ),
    GoRoute(
      path: '/tenant-admin/tenant/:id',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: TenantAdminTenantDetail(id: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
        path: '/tenant-admin/car-tags',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminCarTagList()),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminCarTagDetail(
                  id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
        ]),
    GoRoute(
        path: '/tenant-admin/cars',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminCarList()),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child:
                  TenantAdminCarDetail(id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
        ]),
    GoRoute(
        path: '/tenant-admin/devices',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminDeviceList()),
        routes: [
          GoRoute(
            path: 'add',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminDeviceAdd(refreshItems: state.extra as AsyncCallback),
            ),
          ),
          GoRoute(
            path: 'io/:id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminDeviceIoSimulatedDetail(
                  id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
          GoRoute(
            path: 'io/:id/view',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminDeviceIoSimulatedView(id: state.pathParameters['id']!),
            ),
          ),
        ]),
    GoRoute(
        path: '/tenant-admin/events',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminEventList()),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminEventDetail(
                  id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
        ]),
    GoRoute(
        path: '/tenant-admin/races',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminRaceList()),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminRaceDetail(
                  id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
        ]),
    GoRoute(
        path: '/tenant-admin/tracks',
        pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: const TenantAdminTrackList()),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: TenantAdminTrackDetail(
                  id: state.pathParameters['id']!, oldEtag: state.uri.queryParameters['etag'], refreshItems: state.extra as AsyncCallback),
            ),
          ),
        ]),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const SettingsDetail(),
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const ProfileDetail(),
      ),
    ),
  ],
);

class _Destination {
  const _Destination({required this.widget, this.onPressed, this.menuIndex});
  final Widget widget;
  final VoidCallback? onPressed;
  final int? menuIndex;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void showAbout(BuildContext context, String applicationVersion) {
    showAboutDialog(
        context: context,
        applicationIcon: Text(
          'RazManager',
          style: TextStyle(
            fontFamily: 'BungeeInline',
            fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
            //color: Colors.black,
            //backgroundColor: Colors.yellowAccent)
          ),
        ),
        applicationName: "", // "RazManager",
        children: [
          Row(children: [
            Table(defaultColumnWidth: IntrinsicColumnWidth(), children: [
              TableRow(children: [const TableCell(child: Text('Version:  ')), TableCell(child: Text(applicationVersion))]),
              TableRow(children: [
                const TableCell(child: Text('Operating system:  ')),
                TableCell(
                    child: Text(Platform.isAndroid
                        ? 'Android'
                        : Platform.isFuchsia
                            ? 'isFuchsia'
                            : Platform.isIOS
                                ? 'iOS'
                                : Platform.isLinux
                                    ? 'Linux'
                                    : Platform.isMacOS
                                        ? 'MacOS'
                                        : Platform.isWindows
                                            ? 'Windows'
                                            : '?'))
              ]),
              TableRow(children: [const TableCell(child: Text('Operating system version:  ')), TableCell(child: Text(Platform.operatingSystemVersion))]),
              TableRow(children: [const TableCell(child: Text('Dart runtime:  ')), TableCell(child: Text(Platform.version))]),
            ])
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<AppModel>();
    final destinations = <_Destination>[];

    int menuIndex = 0;
    destinations.add(_Destination(
        widget: const NavigationDrawerDestination(label: Text('Home'), icon: Icon(Icons.home)), onPressed: () => context.go('/'), menuIndex: menuIndex++));
    if (model.tenantRead != null) {
      destinations.add(const _Destination(widget: Divider()));
      destinations.add(_Destination(
          widget: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(child: Text(model.tenantRead!.name, overflow: TextOverflow.ellipsis)),
            const SizedBox(width: 16),
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                  final model = context.read<AppModel>();
                  model.tenantClear();
                  context.go('/');
                }),
          ],
        ),
      )));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Club/Place'), icon: Icon(Icons.place)),
          onPressed: () {
            final model = context.read<AppModel>();
            context.go('/tenant-admin/tenant/${model.tenantId}');
          },
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Events'), icon: Icon(Icons.event)),
          onPressed: () => context.go('/tenant-admin/events'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Races'), icon: Icon(Icons.sports_score)),
          onPressed: () => context.go('/tenant-admin/races'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Devices'), icon: Icon(Icons.devices_other)),
          onPressed: () => context.go('/tenant-admin/devices'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Tracks'), icon: Icon(Icons.edit_road)),
          onPressed: () => context.go('/tenant-admin/tracks'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Points schemes'), icon: Icon(Icons.looks_one)),
          onPressed: () => context.go('/'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Car tags'), icon: Icon(Icons.label)),
          onPressed: () => context.go('/tenant-admin/car-tags'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Cars'), icon: Icon(Icons.drive_eta)),
          onPressed: () => context.go('/tenant-admin/cars'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Autopilots'), icon: Icon(Icons.smart_toy)),
          onPressed: () => context.go('/'),
          menuIndex: menuIndex++));
      destinations.add(_Destination(
          widget: const NavigationDrawerDestination(label: Text('Throttle profiles'), icon: Icon(Icons.speed)),
          onPressed: () => context.go('/'),
          menuIndex: menuIndex++));
      destinations.add(const _Destination(widget: Divider()));
    }
    destinations.add(_Destination(
        widget: const NavigationDrawerDestination(label: Text('Settings'), icon: Icon(Icons.settings)),
        onPressed: () {
          Scaffold.of(context).closeDrawer();
          context.push('/settings');
        },
        menuIndex: menuIndex++));
    destinations.add(_Destination(
        widget: NavigationDrawerDestination(label: const Text('Profile'), icon: const Icon(Icons.manage_accounts), enabled: model.isAuthenticated()),
        onPressed: () => context.go('/profile'),
        menuIndex: menuIndex++));
    destinations.add(_Destination(
        widget: NavigationDrawerDestination(label: const Text('Sign-out'), icon: const Icon(Icons.person_off), enabled: model.isAuthenticated()),
        onPressed: () {
          Scaffold.of(context).closeDrawer();
          final model = context.read<AppModel>();
          model.tokenSignOut();
          context.go('/');
        },
        menuIndex: menuIndex++));
    destinations.add(_Destination(
        widget: const NavigationDrawerDestination(label: Text('About'), icon: Icon(Icons.info)),
        onPressed: () {
          Scaffold.of(context).closeDrawer();
          showAbout(context, model.applicationVersion);
        },
        menuIndex: menuIndex++));

    return NavigationDrawer(
      selectedIndex: model.menuIndex,
      onDestinationSelected: (index) {
        model.menuIndex = index;
        destinations.singleWhere((element) => element.menuIndex == index).onPressed!();
      },
      children: [const SizedBox(height: 16), ...destinations.map((e) => e.widget)],
    );
  }
}
