//
//  CodeValidViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth

final class CodeValidViewController: UIViewController {
    var verificationID: String?
    
    @IBOutlet private weak var codeTextView: UITextView!
    @IBOutlet private weak var confirmCodeButton: UIButton!
    @IBOutlet private weak var sendCodeAgainButton: UIButton!
    @IBOutlet private weak var incorrectCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }
    
    private func setupConfig(){
        confirmCodeButton.blockButton()
        sendCodeAgainButton.blockButton()
        
        codeTextView.delegate = self
    }
    
    private func showChatsViewController(){
        let chatsViewController = ChatsViewController()
        chatsViewController.modalPresentationStyle = .fullScreen
        chatsViewController.modalTransitionStyle = .crossDissolve
        present(chatsViewController, animated: true, completion: nil)
    }
    
    @IBAction private func confirmCodeButtonAction(_ sender: UIButton) {
        guard let verificationID = verificationID,
              let code = codeTextView.text else { return }
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credetional) { _, error in
            if error != nil {
                self.incorrectCodeLabel.isHidden = false
            } else {
                self.incorrectCodeLabel.isHidden = true
                self.showChatsViewController()
            }
        }
    }
    
    @IBAction private func sendCodeAgainButtonAction(_ sender: UIButton) {
    }
}

//MARK: - UITextViewDelegate
extension CodeValidViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount{
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 6{
            confirmCodeButton.mainButton()
        } else {
            confirmCodeButton.blockButton()
        }
    }
}
