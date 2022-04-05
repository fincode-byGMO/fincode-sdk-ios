//
//  MessageDialogViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/31.
//

import UIKit

class MessageDialogViewController: UIViewController {
    
    enum ButtonType: String {
        case close = "閉じる"
        case ok = "OK"
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var dialogTitle: String?
    var dialogMessage: String?
    var buttonType: ButtonType = .close
    var action: ((UIButton) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.extBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        titleLabel.text = dialogTitle
        messageLabel.text = dialogMessage
        button.setTitle(buttonType.rawValue, for: .normal)
    }
    
    @IBAction func didButtonTouch(_ sender: UIButton) {
        self.dismiss(animated: false)
        if let action = action {
            action(sender)
        }
    }
}
