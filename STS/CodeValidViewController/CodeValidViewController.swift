//
//  CodeValidViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit

final class CodeValidViewController: UIViewController {
    @IBOutlet private weak var codeTextView: UITextView!
    @IBOutlet private weak var confirmCodeButton: UIButton!
    @IBOutlet private weak var sendCodeAgainButton: UIButton!
    
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
        showChatsViewController()
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
