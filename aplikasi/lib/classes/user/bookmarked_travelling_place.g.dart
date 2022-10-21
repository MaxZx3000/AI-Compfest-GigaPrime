// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_travelling_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkedTravellingPlaceAdapter
    extends TypeAdapter<BookmarkedTravellingPlace> {
  @override
  final int typeId = 0;

  @override
  BookmarkedTravellingPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkedTravellingPlace(
      rating: fields[0] as int,
      travellingPlace: fields[1] as TravellingPlace,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkedTravellingPlace obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rating)
      ..writeByte(1)
      ..write(obj.travellingPlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkedTravellingPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
