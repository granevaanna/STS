//
//  LoginViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

final class LoginViewController: UIViewController {
    private var listController: FPNCountryListViewController!
    private var phoneNumber: String?
    private var agreementFlag: Bool = false

    @IBOutlet private weak var phoneNumberTextField: FPNTextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var agreementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }
    
    private func setupConfig(){
        continueButton.blockButton()
        
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTextField.countryRepository)
        
        listController.didSelect = { country in
            self.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }
    
    private func showCodeValidViewController(){
        let codeValidViewController = CodeValidViewController()
        codeValidViewController.modalPresentationStyle = .fullScreen
        codeValidViewController.modalTransitionStyle = .crossDissolve
        present(codeValidViewController, animated: true, completion: nil)
    }
    
    @IBAction private func agreementButtonAction(_ sender: UIButton) {
        agreementFlag.toggle()
        if agreementFlag{
            agreementButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            agreementButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction private func continueButtonAction(_ sender: UIButton) {
        guard let phoneNumber = phoneNumber else { return }

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if error != nil{
                print(error?.localizedDescription)
            } else {
                self.showCodeValidViewController()
            }
        }
    }
}

//MARK: - FPNTextFieldDelegate
extension LoginViewController: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid{
//            if agreementFlag{
//                continueButton.mainButton()
//                phoneNumber = textField.getFormattedPhoneNumber(format: .International)
//            }
            continueButton.mainButton()
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            continueButton.blockButton()
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        phoneNumberTextField.text = ""
        present(navigationController, animated: true, completion: nil)
    }
}
