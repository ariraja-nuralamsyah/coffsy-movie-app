import '../../domain/entities/trailer.dart';

class TrailerMapper {
  static List<Trailer> fromMapList(Map<String, dynamic> map) => List<Trailer>.from((map['results'] ?? []).map(TrailerMapper.fromMap));

  static Trailer fromMap(dynamic map) {
    return Trailer(
      map['id'],
      map['key'],
      map['name'],
    );
  }

  static Map<dynamic, dynamic> toMap(Trailer trailer) {
    return {
      'id': trailer.trailerId,
      'key': trailer.youtubeId,
      'name': trailer.title,
    };
  }
}
