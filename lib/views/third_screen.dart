import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/viewmodels/third_viewmodel.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ThirdViewModel>(context, listen: false).fetchInitialUsers();
    });

    _scrollController.addListener(() {
      final provider = Provider.of<ThirdViewModel>(context, listen: false);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !provider.isLoading &&
          provider.hasMore) {
        provider.loadMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: BackButton(color: Colors.black),
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<ThirdViewModel>(
        builder: (context, provider, child) {
          if (provider.users.isEmpty && provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.users.isEmpty) {
            return const Center(child: Text("No users found."));
          }

          return RefreshIndicator(
            onRefresh: provider.refreshUsers,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: provider.users.length + (provider.hasMore ? 1 : 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              separatorBuilder: (_, __) => const Divider(indent: 24, endIndent: 24),
              itemBuilder: (context, index) {
                if (index < provider.users.length) {
                  final user = provider.users[index];
                  return ListTile(
                    onTap: () => Navigator.pop(
                      context,
                      "${user.firstName} ${user.lastName}",
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      user.email,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  );
                } else {
                  // loader saat load more
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
