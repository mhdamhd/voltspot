

import '../../entities/base_entity.dart';
import '../../models/base_model.dart';

extension ToEntityListX<E extends BaseEntity> on Iterable<BaseModel<E>> {
  List<E> toEntityList() => map((m) => m.toEntity()).toList();
}