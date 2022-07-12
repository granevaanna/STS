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
    var phoneNumber: String?
    
    var timer = Timer()
    var durationTimer = 60
    
    @IBOutlet private weak var codeTextView: UITextView!
    @IBOutlet private weak var confirmCodeButton: UIButton!
    @IBOutlet private weak var sendCodeAgainButton: UIButton!
    @IBOutlet private weak var incorrectCodeLabel: UILabel!
    @IBOutlet private weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        
        setupConfig()
    }
    
    private func setupConfig(){
        confirmCodeButton.blockButton()
        sendCodeAgainButton.blockButton()
        
        codeTextView.delegate = self
    }
    
    private func startTimer(){
        durationTimer = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        durationTimer -= 1
        if durationTimer < 10{
            timerLabel.text = "Не получили код? - Запросите повторную отправку через 00:0\(durationTimer):"
        } else{
            timerLabel.text = "Не получили код? - Запросите повторную отправку через 00:\(durationTimer):"
        }
        
        if durationTimer == 0{
            timer.invalidate()
            timerLabel.text = "Не получили код? - Запросите повторную отправку:"
            sendCodeAgainButton.mainButton()
        }
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
        sendCodeAgainButton.blockButton()
        startTimer()
        
        guard let phoneNumber = phoneNumber else { return }

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if error != nil{
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.verificationID = verificationID
            }
        }
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
