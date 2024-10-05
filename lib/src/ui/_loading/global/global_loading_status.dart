sealed class GlobalLoadingStatus {
  const GlobalLoadingStatus(this.localizationKey);

  final String localizationKey;
}

final class GlobalLoadingActive extends GlobalLoadingStatus {
  const GlobalLoadingActive(super.localizationKey);
}

final class GlobalLoadingSuccess extends GlobalLoadingStatus {
  const GlobalLoadingSuccess(super.localizationKey);
}

final class GlobalLoadingFailed extends GlobalLoadingStatus {
  const GlobalLoadingFailed(super.localizationKey);
}
