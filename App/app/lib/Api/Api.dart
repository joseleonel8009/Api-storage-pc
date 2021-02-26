class Api {
  String path;
  Content content;
  bool success;

  Api({this.path, this.content, this.success});

  Api.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Content {
  List<String> files;
  List<String> directories;
  List<String> all;

  Content({this.files, this.directories, this.all});

  Content.fromJson(Map<String, dynamic> json) {
    files = json['files'].cast<String>();
    directories = json['directories'].cast<String>();
    all = json['all'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['files'] = this.files;
    data['directories'] = this.directories;
    data['all'] = this.all;
    return data;
  }
}
