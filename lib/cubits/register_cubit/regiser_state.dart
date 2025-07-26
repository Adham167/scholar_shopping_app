part of 'regiser_cubit.dart';

@immutable
sealed class RegiserState {}

final class RegiserInitial extends RegiserState {}

final class RegiserLoading extends RegiserState {}

final class RegiserSuccess extends RegiserState {}

final class RegiserFailure extends RegiserState {
  String errMessage;
  RegiserFailure(this.errMessage);
}
