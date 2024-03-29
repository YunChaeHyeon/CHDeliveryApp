

import UIKit
import TossPayments

open class ViewController: UIViewController {
    public lazy var scrollView = UIScrollView()
    public lazy var stackView = UIStackView()

    public var scrollViewBottomAnchorConstraint: NSLayoutConstraint?
    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag

        stackView.spacing = 24
        stackView.axis = .vertical

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

class PaymentWidgetViewController: ViewController {

    private lazy var widget: PaymentWidget = PaymentWidget(
        clientKey: "test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq",
        customerKey: "EPUx4U0_zvKaGMZkA7uF_"
    )

    private lazy var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("결제하기", for: .normal)
        button.addTarget(self, action: #selector(requestPayment), for: .touchUpInside)

        let paymentMethods = widget.renderPaymentMethods(amount: PaymentMethodWidget.Amount(value: 10000))
        let agreement = widget.renderAgreement()

        stackView.addArrangedSubview(paymentMethods)
        stackView.addArrangedSubview(agreement)
        stackView.addArrangedSubview(button)

        widget.delegate = self
        widget.paymentMethodWidget?.widgetStatusDelegate = self;
    }

    @objc func requestPayment() {
        widget.requestPayment(
            info: DefaultWidgetPaymentInfo(
                orderId: "2VAhXURbYbiKwX5ybfrLr",
                orderName: "토스 티셔츠 외 2건")
            //,on: self
        )
    }

}

extension PaymentWidgetViewController: TossPaymentsDelegate {
    public func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        print("결제 성공")
        print("paymentKey: \(success.paymentKey)")
        print("orderId: \(success.orderId)")
        print("amount: \(success.amount)")
    }

    public func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        print("결제 실패")
        print("errorCode: \(fail.errorCode)")
        print("errorMessage: \(fail.errorMessage)")
        print("orderId: \(fail.orderId)")

    }
}
extension PaymentWidgetViewController: TossPaymentsWidgetStatusDelegate {
    public func didReceivedLoad(_ name: String) {
        print("결제위젯 렌더링 완료 ")
    }
}
