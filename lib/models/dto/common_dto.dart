abstract class Serializable {
  Map<String, dynamic> toJson();
  Serializable fromJson(Map<String, dynamic> json);
}

class ResBody<T extends Serializable> extends Serializable {
  final T? data;
  final String? message;
  final String? status;
  final String? timestamp;

  ResBody({this.data, this.message, this.status, this.timestamp});

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'status': status,
      'timestamp': timestamp,
    };
  }

  @override
  ResBody<T> fromJson(Map<String, dynamic> json) {
    return ResBody<T>(
      data: json['data'] != null ? (data?.fromJson(json['data']) as T) : null,
      message: json['message'] as String?,
      status: json['status'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }
}

class Page<T extends Serializable> {
  final List<T>? content;
  final int? totalElements;
  final int? numberOfElements;
  final int? totalPages;
  final int? size;
  final int? number;
  final bool? last;
  final bool? first;

  Page({
    this.content,
    this.totalElements,
    this.numberOfElements,
    this.totalPages,
    this.size,
    this.number,
    this.last,
    this.first,
    T Function(dynamic)? fromJsonFactory,
  });

  factory Page.empty() {
    return Page<T>(
      content: [],
      totalElements: 0,
      numberOfElements: 0,
      totalPages: 0,
      size: 0,
      number: 0,
      last: true,
      first: true,
    );
  }

  factory Page.fromJson(Map<String, dynamic> json, T Function(dynamic) dataItemFromJson) {
    return Page<T>(
      content: json['content'] != null
          ? (json['content'] as List<dynamic>)
              .map((item) => dataItemFromJson(item))
              .toList()
          : null,
      totalElements: json['totalElements'] as int?,
      numberOfElements: json['numberOfElements'] as int?,
      totalPages: json['totalPages'] as int?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      last: json['last'] as bool?,
      first: json['first'] as bool?,
    );
  }
  
  Page<T> fromJson(Map<String, dynamic> json, T Function(dynamic) dataItemFromJson) {
    return Page.fromJson(json, dataItemFromJson);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'content': content?.map((item) => item.toJson()).toList(),
      'totalElements': totalElements,
      'numberOfElements': numberOfElements,
      'totalPages': totalPages,
      'size': size,
      'number': number,
      'last': last,
      'first': first,
    };
  }
}

class PaginatedResBody<T extends Serializable> {
  final Page<T>? data;
  final String? message;
  final String? status;
  final String? timestamp;

  PaginatedResBody({this.data, this.message, this.status, this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'status': status,
      'timestamp': timestamp,
    };
  }

  PaginatedResBody<T> fromJson(Map<String, dynamic> json, T Function(dynamic) dataItemFromJson) {
    return PaginatedResBody<T>(
      data: json['data'] != null ? Page<T>().fromJson(json['data'] as Map<String, dynamic>, dataItemFromJson) : null,
      message: json['message'] as String?,
      status: json['status'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }
}