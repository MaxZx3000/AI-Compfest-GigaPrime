// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travelling_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravellingPlaceAdapter extends TypeAdapter<TravellingPlace> {
  @override
  final int typeId = 1;

  @override
  TravellingPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravellingPlace(
      placeId: fields[0] as int,
      placeName: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      city: fields[4] as String,
      price: fields[5] as int?,
      rating: fields[6] as double?,
      latitude: fields[8] as double?,
      longitude: fields[9] as double?,
      timeMinutes: fields[7] as int?,
      summarizedDescription: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TravellingPlace obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.placeName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.timeMinutes)
      ..writeByte(8)
      ..write(obj.latitude)
      ..writeByte(9)
      ..write(obj.longitude)
      ..writeByte(10)
      ..write(obj.summarizedDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravellingPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
