class AppInitService {
  Future<void> init() async {
    // Initialize any services (e.g., storage, network) here
    await Future.delayed(const Duration(milliseconds: 500)); // Simulated init
  }
}