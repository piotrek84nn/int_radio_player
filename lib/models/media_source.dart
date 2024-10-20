class MediaSources {
  MediaSources({
    String? url,
    String? title,
    String? logo,
  }) {
    if (url != null) {
      this.url = url;
    }
    if (title != null) {
      this.title = title;
    }
    if (logo != null) {
      this.logo = logo;
    }
  }
  MediaSources.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    title = json['title'] as String?;
    logo = json['logo'] as String?;
  }
  String? url;
  String? title;
  String? logo;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    data['logo'] = logo;
    return data;
  }

  MediaSources copyWith({
    String? url,
    String? title,
    String? logo,
  }) {
    return MediaSources(
      url: url ?? this.url,
      title: title ?? this.title,
      logo: logo ?? this.logo,
    );
  }
}
