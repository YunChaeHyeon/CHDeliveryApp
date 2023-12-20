//
//  TossPaymentContentView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 12/19/23.
//

#if !os(macOS) && canImport(SwiftUI)
import SwiftUI
import TossPayments

private enum Constants {
    static let clientKey: String = "test_ck_P24xLea5zVAqkMGkoG7VQAMYNwW6"
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스"
    )
}

struct TossPaymentsContentView: View {
    @State private var showingSuccess: Bool = false
    @State private var showingFail: Bool = false
    var paymentPrice : Int
    
    
    @StateObject
    var viewModel = TossPaymentsContentViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PaymentMethodWidgetView(widget: viewModel.widget, amount: PaymentMethodWidget.Amount(value: 1000))
                AgreementWidgetView(widget: viewModel.widget)
            }
        }
//        Button("\(paymentPrice)원 결제하기") {
//            viewModel.requestPayment(info: DefaultWidgetPaymentInfo(orderId: "123", orderName: "김토스"))
//        }
        Button(action: {
            viewModel.requestPayment(info: DefaultWidgetPaymentInfo(orderId: "123", orderName: "김토스"))
        }, label: {
            Text("\(paymentPrice)원 결제하기")
                .font(.system(size:20 , weight: .bold))
                .foregroundColor(Color.white)
                .frame(width: 250, height: 50)
        }).background(Color.blue)
            .cornerRadius(15)
            .padding(10)

        .alert(isPresented: $showingSuccess, content: {
            Alert(title: Text(verbatim: "Success"), message: Text(verbatim: viewModel.onSuccess?.orderId ?? ""))
        })
        .alert(isPresented: $showingFail, content: {
            Alert(title: Text(verbatim: "Fail"), message: Text(verbatim: viewModel.onFail?.orderId ?? ""))
        })
        .onReceive(viewModel.$onSuccess.compactMap { $0 }) { success in
            showingSuccess = true
        }
        .onReceive(viewModel.$onFail.compactMap { $0 }) { fail in
            showingFail = true
        }
    }
}


#endif

