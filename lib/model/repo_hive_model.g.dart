// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GitHubRepoHiveAdapter extends TypeAdapter<GitHubRepoHive> {
  @override
  final int typeId = 1;

  @override
  GitHubRepoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GitHubRepoHive(
      fullName: fields[0] as String?,
      description: fields[1] as String?,
      starCount: fields[2] as String?,
      imageUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GitHubRepoHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.starCount)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitHubRepoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
