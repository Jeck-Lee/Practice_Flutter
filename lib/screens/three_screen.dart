import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter/network/api_repository.dart';
import 'package:practice_flutter/network/storage_repository.dart';
import 'package:provider/provider.dart';

import '../router_provider.dart';

class ThreeScreen extends StatelessWidget {
  const ThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThreeView();
  }
}

class ThreeView extends StatelessWidget {
  const ThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<RouterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Three"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 48),
              const Text("Here is the Three"),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () async {
                  final storageRepository = GetIt.instance<StorageRepository>();
                  await storageRepository.saveRefreshToken("abcd");
                  final token = await storageRepository.readToken();
                  if (token != null) {
                    await GetIt.instance<ApiRepository>().test(token: token);
                  }
                },
                child: const Text("Test API"),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final storageRepository = GetIt.instance<StorageRepository>();
                  await storageRepository.saveRefreshToken("1234");
                  final token = await storageRepository.readToken();
                  if (token != null) {
                    await GetIt.instance<ApiRepository>().test(token: token);
                  }
                },
                child: const Text("Test API with\nExpired refreshToken"),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  router.logout();
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
