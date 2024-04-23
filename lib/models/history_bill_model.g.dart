// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryBillModelAdapter extends TypeAdapter<HistoryBillModel> {
  @override
  final int typeId = 2;

  @override
  HistoryBillModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryBillModel(
      category: fields[0] as String,
      amount: fields[1] as int,
      date: fields[2] as DateTime,
      type: fields[3] as FinanceType,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryBillModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryBillModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
