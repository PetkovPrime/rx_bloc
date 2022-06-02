import 'package:github_search/base/models/github_repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_repos_reponse.g.dart';

@JsonSerializable()
class GithubReposResponse {
  GithubReposResponse({
    required this.totalCount,
    required this.items,
  });

  factory GithubReposResponse.fromJson(Map<String, dynamic> json) =>
      _$GithubReposResponseFromJson(json);

  @JsonKey(name: 'total_count')
  final int totalCount;

  final List<GithubRepo> items;

  Map<String, dynamic> toJson() => _$GithubReposResponseToJson(this);
}
