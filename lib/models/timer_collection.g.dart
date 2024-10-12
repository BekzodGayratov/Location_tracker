// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerCollectionCollection on Isar {
  IsarCollection<TimerCollection> get timerCollections => this.collection();
}

const TimerCollectionSchema = CollectionSchema(
  name: r'TimerCollection',
  id: 9146544829791163139,
  properties: {
    r'seconds': PropertySchema(
      id: 0,
      name: r'seconds',
      type: IsarType.long,
    )
  },
  estimateSize: _timerCollectionEstimateSize,
  serialize: _timerCollectionSerialize,
  deserialize: _timerCollectionDeserialize,
  deserializeProp: _timerCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timerCollectionGetId,
  getLinks: _timerCollectionGetLinks,
  attach: _timerCollectionAttach,
  version: '3.1.0+1',
);

int _timerCollectionEstimateSize(
  TimerCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _timerCollectionSerialize(
  TimerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.seconds);
}

TimerCollection _timerCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimerCollection();
  object.id = id;
  object.seconds = reader.readLong(offsets[0]);
  return object;
}

P _timerCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timerCollectionGetId(TimerCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerCollectionGetLinks(TimerCollection object) {
  return [];
}

void _timerCollectionAttach(
    IsarCollection<dynamic> col, Id id, TimerCollection object) {
  object.id = id;
}

extension TimerCollectionQueryWhereSort
    on QueryBuilder<TimerCollection, TimerCollection, QWhere> {
  QueryBuilder<TimerCollection, TimerCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimerCollectionQueryWhere
    on QueryBuilder<TimerCollection, TimerCollection, QWhereClause> {
  QueryBuilder<TimerCollection, TimerCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerCollectionQueryFilter
    on QueryBuilder<TimerCollection, TimerCollection, QFilterCondition> {
  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      secondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      secondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      secondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterFilterCondition>
      secondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerCollectionQueryObject
    on QueryBuilder<TimerCollection, TimerCollection, QFilterCondition> {}

extension TimerCollectionQueryLinks
    on QueryBuilder<TimerCollection, TimerCollection, QFilterCondition> {}

extension TimerCollectionQuerySortBy
    on QueryBuilder<TimerCollection, TimerCollection, QSortBy> {
  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy> sortBySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seconds', Sort.asc);
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy>
      sortBySecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seconds', Sort.desc);
    });
  }
}

extension TimerCollectionQuerySortThenBy
    on QueryBuilder<TimerCollection, TimerCollection, QSortThenBy> {
  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy> thenBySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seconds', Sort.asc);
    });
  }

  QueryBuilder<TimerCollection, TimerCollection, QAfterSortBy>
      thenBySecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seconds', Sort.desc);
    });
  }
}

extension TimerCollectionQueryWhereDistinct
    on QueryBuilder<TimerCollection, TimerCollection, QDistinct> {
  QueryBuilder<TimerCollection, TimerCollection, QDistinct>
      distinctBySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seconds');
    });
  }
}

extension TimerCollectionQueryProperty
    on QueryBuilder<TimerCollection, TimerCollection, QQueryProperty> {
  QueryBuilder<TimerCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimerCollection, int, QQueryOperations> secondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seconds');
    });
  }
}
