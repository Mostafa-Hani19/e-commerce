import 'package:ecommerce/core/network/api_service.dart';
import 'package:ecommerce/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>((
  ref,
) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final ApiService _apiService = ApiService();

  UserNotifier() : super(const AsyncValue.loading()) {
    fetchUser();
  }

  Future<void> fetchUser({int id = 1}) async {
    try {
      state = const AsyncValue.loading();
      final user = await _apiService.getUser(id);
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void updateAddress(Address newAddress) {
    state.whenData((user) {
      // Simulate API update by updating local state
      // In a real app, we would call _apiService.updateAddress(...)
      state = AsyncValue.data(
        User(
          id: user.id,
          email: user.email,
          username: user.username,
          name: user.name,
          address: newAddress,
          phone: user.phone,
        ),
      );
    });
  }
}
