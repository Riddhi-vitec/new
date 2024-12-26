part of 'my_products_bloc.dart';

@immutable
abstract class MyProductsEvent extends Equatable{
  const MyProductsEvent();
  @override
  List<Object?> get props => [];
}

class TriggerFetchLocalProducts extends MyProductsEvent {
  const TriggerFetchLocalProducts();
}
class TriggerCreateOptionEvent extends MyProductsEvent{}
class TriggerEditOptionEvent extends MyProductsEvent {
  final int productID;
  final String? name, price, stock;
  const TriggerEditOptionEvent({required this.productID, required this.name, required this.price, required this.stock});
  @override
  List<Object?> get props => [productID, name, price, stock];
}
class TriggerAddLocalProduct extends MyProductsEvent {
  final String name, price, stock;
  const TriggerAddLocalProduct({required this.name, required this.price, required this.stock});
  @override
  List<Object?> get props => [name, price, stock,];
}
class TriggerUpdateLocalProduct extends MyProductsEvent {
  final int id;
  final String? name, price, stock;
  const TriggerUpdateLocalProduct({required this.id, this.name, this.price, this.stock});
  @override
  List<Object?> get props => [id, name, price, stock];
}
class TriggerDeleteLocalProduct extends MyProductsEvent {
  final int id;
  const TriggerDeleteLocalProduct({required this.id});
  @override
  List<Object?> get props => [id];
}
class TriggerFieldValidation extends MyProductsEvent {
  final String fieldInput;
  final int fieldNumber;
  const TriggerFieldValidation({required this.fieldInput, required this.fieldNumber});
  @override
  List<Object?> get props => [fieldInput, fieldNumber];
}

class TriggerChooseImageFromGallery extends MyProductsEvent {

  const TriggerChooseImageFromGallery();

}