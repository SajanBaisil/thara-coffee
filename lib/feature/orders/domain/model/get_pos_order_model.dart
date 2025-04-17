import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class GetPosOrdersModel with EquatableMixin {
  List<Data>? data;
  String? message;
  String? status;
  String? success;

  GetPosOrdersModel({this.data, this.message, this.status, this.success});

  GetPosOrdersModel.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
    success = json['success'];
  }

  // Add this getter to get all lines in a single list
  List<Lines> get allLines {
    final List<Lines> allLines = [];
    if (data != null) {
      for (var order in data!) {
        if (order.lines != null) {
          allLines.addAll(order.lines!);
        }
      }
    }
    return allLines;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    data['success'] = success;
    return data;
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
        success,
      ];
}

class Data with EquatableMixin {
  String? amountTax;
  String? amountTotal;
  String? dateOrder;
  String? id;
  List<Lines>? lines;
  String? name;
  // List<PaymentIds>? paymentIds;
  String? state;

  Data(
      {this.amountTax,
      this.amountTotal,
      this.dateOrder,
      this.id,
      this.lines,
      this.name,
      // this.paymentIds,
      this.state});

  Data.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    amountTax = json['amount_tax'];
    amountTotal = json['amount_total'];

    dateOrder = json['date_order'];
    id = json['id'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(Lines.fromJson(v));
      });
    }
    name = json['name'];
    // if (json['payment_ids'] != null) {
    //   paymentIds = <PaymentIds>[];
    //   json['payment_ids'].forEach((v) {
    //     paymentIds!.add(PaymentIds.fromJson(v));
    //   });
    // }
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount_tax'] = amountTax;
    data['amount_total'] = amountTotal;

    data['date_order'] = dateOrder;
    data['id'] = id;
    if (lines != null) {
      data['lines'] = lines!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    // if (paymentIds != null) {
    //   data['payment_ids'] = paymentIds!.map((v) => v.toJson()).toList();
    // }
    data['state'] = state;
    return data;
  }

  @override
  List<Object?> get props => [
        amountTax,
        amountTotal,
        dateOrder,
        id,
        lines,
        name,
        // paymentIds,
        state,
      ];
}

class Lines with EquatableMixin {
  String? customerNote;
  String? discount;
  String? priceUnit;
  String? product;
  String? productId;
  String? qty;
  String? subtotal;

  Lines(
      {this.customerNote,
      this.discount,
      this.priceUnit,
      this.product,
      this.productId,
      this.qty,
      this.subtotal});

  Lines.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    customerNote = json['customer_note'];
    discount = json['discount'];
    priceUnit = json['price_unit'];
    product = json['product'];
    productId = json['product_id'];
    qty = json['qty'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_note'] = customerNote;
    data['discount'] = discount;
    data['price_unit'] = priceUnit;
    data['product'] = product;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['subtotal'] = subtotal;
    return data;
  }

  @override
  List<Object?> get props => [
        customerNote,
        discount,
        priceUnit,
        product,
        productId,
        qty,
        subtotal,
      ];
}

// class PaymentIds {
//   List<Null>? accountMoveId;
//   double? amount;
//   bool? cardType;
//   bool? cardholderName;
//   List<int>? companyId;
//   String? createDate;
//   List<int>? createUid;
//   List<int>? currencyId;
//   int? currencyRate;
//   String? displayName;
//   int? id;
//   bool? isChange;
//   bool? name;
//   List<Null>? onlineAccountPaymentId;
//   List<int>? partnerId;
//   String? paymentDate;
//   List<int>? paymentMethodId;
//   bool? paymentStatus;
//   List<int>? posOrderId;
//   List<int>? sessionId;
//   bool? ticket;
//   bool? transactionId;
//   String? writeDate;
//   List<int>? writeUid;

//   PaymentIds(
//       {this.accountMoveId,
//       this.amount,
//       this.cardType,
//       this.cardholderName,
//       this.companyId,
//       this.createDate,
//       this.createUid,
//       this.currencyId,
//       this.currencyRate,
//       this.displayName,
//       this.id,
//       this.isChange,
//       this.name,
//       this.onlineAccountPaymentId,
//       this.partnerId,
//       this.paymentDate,
//       this.paymentMethodId,
//       this.paymentStatus,
//       this.posOrderId,
//       this.sessionId,
//       this.ticket,
//       this.transactionId,
//       this.writeDate,
//       this.writeUid});

//   PaymentIds.fromJson(Map<String, dynamic> json) {
//     // if (json['account_move_id'] != null) {
//     //   accountMoveId = <Null>[];
//     //   json['account_move_id'].forEach((v) {
//     //     accountMoveId!.add(Null.fromJson(v));
//     //   });
//     // }
//     amount = json['amount'];
//     cardType = json['card_type'];
//     cardholderName = json['cardholder_name'];
//     companyId = json['company_id'].cast<int>();
//     createDate = json['create_date'];
//     createUid = json['create_uid'].cast<int>();
//     currencyId = json['currency_id'].cast<int>();
//     currencyRate = json['currency_rate'];
//     displayName = json['display_name'];
//     id = json['id'];
//     isChange = json['is_change'];
//     name = json['name'];
//     if (json['online_account_payment_id'] != null) {
//       onlineAccountPaymentId = <Null>[];
//       json['online_account_payment_id'].forEach((v) {
//         onlineAccountPaymentId!.add(Null.fromJson(v));
//       });
//     }
//     partnerId = json['partner_id'].cast<int>();
//     paymentDate = json['payment_date'];
//     paymentMethodId = json['payment_method_id'].cast<int>();
//     paymentStatus = json['payment_status'];
//     posOrderId = json['pos_order_id'].cast<int>();
//     sessionId = json['session_id'].cast<int>();
//     ticket = json['ticket'];
//     transactionId = json['transaction_id'];
//     writeDate = json['write_date'];
//     writeUid = json['write_uid'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (accountMoveId != null) {
//       data['account_move_id'] = accountMoveId!.map((v) => v.toJson()).toList();
//     }
//     data['amount'] = amount;
//     data['card_type'] = cardType;
//     data['cardholder_name'] = cardholderName;
//     data['company_id'] = companyId;
//     data['create_date'] = createDate;
//     data['create_uid'] = createUid;
//     data['currency_id'] = currencyId;
//     data['currency_rate'] = currencyRate;
//     data['display_name'] = displayName;
//     data['id'] = id;
//     data['is_change'] = isChange;
//     data['name'] = name;
//     if (onlineAccountPaymentId != null) {
//       data['online_account_payment_id'] =
//           onlineAccountPaymentId!.map((v) => v.toJson()).toList();
//     }
//     data['partner_id'] = partnerId;
//     data['payment_date'] = paymentDate;
//     data['payment_method_id'] = paymentMethodId;
//     data['payment_status'] = paymentStatus;
//     data['pos_order_id'] = posOrderId;
//     data['session_id'] = sessionId;
//     data['ticket'] = ticket;
//     data['transaction_id'] = transactionId;
//     data['write_date'] = writeDate;
//     data['write_uid'] = writeUid;
//     return data;
//   }
// }
