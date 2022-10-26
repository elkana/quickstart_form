// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      username: fields[0] as String?,
      userPassword: fields[1] as String?,
      fullName: fields[2] as String?,
      email: fields[3] as String?,
      isAnonym: fields[4] as bool?,
      avatarUrl: fields[5] as String?,
      token: fields[6] as String?,
      userStatus: fields[7] as String?,
      rememberMe: fields[8] as bool?,
      emailVerified: fields[9] as bool?,
      phone: fields[10] as String?,
      createdDate: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.userPassword)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.isAnonym)
      ..writeByte(5)
      ..write(obj.avatarUrl)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.userStatus)
      ..writeByte(8)
      ..write(obj.rememberMe)
      ..writeByte(9)
      ..write(obj.emailVerified)
      ..writeByte(10)
      ..write(obj.phone)
      ..writeByte(11)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
