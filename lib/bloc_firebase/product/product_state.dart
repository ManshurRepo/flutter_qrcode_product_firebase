part of 'product_bloc.dart';

abstract class ProductState {}

final class StateInitial extends ProductState {}

final class StateLoadingAdd extends ProductState {}

final class StateLoadingEdit extends ProductState {}

final class StateLoadingDelete extends ProductState {}

final class StateLoadingExport extends ProductState {}

final class StateSuccessAdd extends ProductState {}

final class StateSuccessEdit extends ProductState {}

final class StateSuccessDelete extends ProductState {}

final class StateSuccessExport extends ProductState {}

final class StateError extends ProductState {
  StateError(this.message);
  final String message;
}
