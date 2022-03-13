import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'todos_record.g.dart';

abstract class TodosRecord implements Built<TodosRecord, TodosRecordBuilder> {
  static Serializer<TodosRecord> get serializer => _$todosRecordSerializer;

  @nullable
  String get title;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get severe;

  @nullable
  @BuiltValueField(wireName: 'is_done')
  bool get isDone;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TodosRecordBuilder builder) => builder
    ..title = ''
    ..severe = ''
    ..isDone = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('todos');

  static Stream<TodosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TodosRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TodosRecord._();
  factory TodosRecord([void Function(TodosRecordBuilder) updates]) =
      _$TodosRecord;

  static TodosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTodosRecordData({
  String title,
  DateTime createdTime,
  String severe,
  bool isDone,
}) =>
    serializers.toFirestore(
        TodosRecord.serializer,
        TodosRecord((t) => t
          ..title = title
          ..createdTime = createdTime
          ..severe = severe
          ..isDone = isDone));
