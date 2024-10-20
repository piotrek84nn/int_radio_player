abstract class ILocator {
  ILocator initialize();
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  });
}
