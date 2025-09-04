class AppStateModel {
  final bool isFirstTime;
  final bool isLoggedIn;
  
  AppStateModel({
    required this.isFirstTime,
    required this.isLoggedIn,
  });
  
  AppStateModel copyWith({
    bool? isFirstTime,
    bool? isLoggedIn,
  }) {
    return AppStateModel(
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}