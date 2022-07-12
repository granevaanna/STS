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
    private var isAgreement: Bool = false
    private var isValidCode:Bool = false

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
    
    private func showCodeValidViewController(verificationID: String){
        let codeValidViewController = CodeValidViewController()
        codeValidViewController.verificationID = verificationID
        codeValidViewController.phoneNumber = phoneNumber
        codeValidViewController.modalPresentationStyle = .fullScreen
        codeValidViewController.modalTransitionStyle = .crossDissolve
        present(codeValidViewController, animated: true, completion: nil)
    }
    
    @IBAction private func agreementButtonAction(_ sender: UIButton) {
        isAgreement.toggle()
        if isAgreement{
            agreementButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            if isValidCode{
                continueButton.mainButton()
                phoneNumber = phoneNumberTextField.getFormattedPhoneNumber(format: .International)
            }
        } else {
            agreementButton.setImage(UIImage(systemName: "square"), for: .normal)
            continueButton.blockButton()
        }
    }
    
    @IBAction private func continueButtonAction(_ sender: UIButton) {
        FirebaseManager.verifyPhoneNumber(phoneNumber: phoneNumber) { [weak self] verificationID in
            guard let self = self else {return}
            DispatchQueue.main.async {
                guard let verificationID = verificationID else { return }
                self.showCodeValidViewController(verificationID: verificationID)
            }
        }
    }
}


//MARK: - FPNTextFieldDelegate
extension LoginViewController: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isValidCode = isValid
        if isValid{
            if isAgreement{
                continueButton.mainButton()
                phoneNumber = textField.getFormattedPhoneNumber(format: .International)
            }
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
