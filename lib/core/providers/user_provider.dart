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
      // Only set loading if not already data to prevent UI flicker on refresh
      if (state.value == null) state = const AsyncValue.loading();
      final user = await _apiService.getUser(id);
      if (mounted) state = AsyncValue.data(user);
    } catch (e, stack) {
      if (mounted) state = AsyncValue.error(e, stack);
    }
  }

  void updateAddress(Address newAddress) {
    // Optimistic update
    state.whenData((user) {
      state = AsyncValue.data(user.copyWith(address: newAddress));
      // In a real app, you'd trigger the API call here:
      // await _apiService.updateAddress(user.id, newAddress);
    });
  }
}
