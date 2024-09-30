import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_paginated_data_queries.freezed.dart';

part 'get_paginated_data_queries.g.dart';

String _convertFilter(String name, List<Map<String, dynamic>> list) {
  var query = '';

  for (var i = 0; i < list.length; i++) {
    final value = list[i]['value'];
    final id = list[i]['id'];

    query += '$name[$i][id]=$id&';

    if (value is List) {
      for (var j = 0; j < value.length; j++) {
        query += '$name[$i][value][$j]=${value[j]}';
        if (j < value.length - 1) {
          query += '&';
        }
      }
    } else {
      query += '$name[$i][value]=$value';
    }

    if (i < list.length - 1) {
      query += '&';
    }
  }

  return query;
}

@freezed
class GetPaginatedDataQueries with _$GetPaginatedDataQueries {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory GetPaginatedDataQueries({
    int? page,
    int? limit,
    List<Map<String, dynamic>>? filters,
    List<Map<String, dynamic>>? sort,
  }) = _GetPaginatedDataQueries;

  factory GetPaginatedDataQueries.fromJson(Map<String, dynamic> json) =>
      _$GetPaginatedDataQueriesFromJson(json);

  const GetPaginatedDataQueries._();

  String toQuery() {
    final query = <String>[];
    if (page != null) {
      query.add('page=$page');
    }

    if (limit != null) {
      query.add('limit=$limit');
    }

    if (filters != null) {
      query.add(_convertFilter('filters', filters!));
    }

    if (sort != null) {
      query.add(_convertFilter('sort', sort!));
    }

    return query.join('&');
  }
}
