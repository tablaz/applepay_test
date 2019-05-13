//
//  ViewController.swift
//  applepay_test
//
//  Created by Ricardo Restrepo on 05/04/2019.
//  Copyright © 2019 Leroy Merlin. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK - Properties
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.leroymerlin.app.retail"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["ES","US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "ES"
        request.currencyCode = "EUR"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPhone Xs 64 Gb", amount: 99.99)]
        return request
    }()
    
    @IBAction func purchaseItem(_ sender: Any) {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
}
extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
