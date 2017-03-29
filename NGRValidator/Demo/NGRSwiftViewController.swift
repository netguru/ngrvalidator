//
//  NGRSwiftViewController.swift
//  NGRValidator
//

import UIKit
import NGRValidator

final class NGRSwiftViewController: UIViewController {
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password..."
        
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let validateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Validate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [passwordTextField, nameTextField, validateButton]
            .forEach(view.addSubview)
        
        let views = ["passwordTextField": passwordTextField, "button": validateButton, "nameTextField": nameTextField]
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-100-[nameTextField]-20-[passwordTextField]-20-[button]",
            options: [.alignAllLeading,.alignAllTrailing],
            metrics: nil,
            views: views
        )
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[nameTextField]-20-|",
            options: [],
            metrics: nil,
            views: views
        )
        
        NSLayoutConstraint.activate([verticalConstraints, horizontalConstraints].flatMap { $0 })
        
        validateButton.addTarget(self, action: #selector(validateAction), for: .touchUpInside)
    }
    
    func validateAction() {
        
        let user = User(name: nameTextField.text!, password: passwordTextField.text!)
        
        let validationErrors = NGRValidator.validate(model: user) { () -> [NGRPropertyValidator]? in
            return [
                NGRPropertyValidator(property: "password")?.is.required().to.have.minLength(5).msgTooShort("should have at least 5 signs"),
                NGRPropertyValidator(property: "name")?.is.required().to.have.syntax(.name).msgWrongSyntax(.name, "should have name syntax"),
                NGRPropertyValidator(property: "isAdmin")?.is.required().to.beTrue().msgNotTrue("should be admin"),
                NGRPropertyValidator(property: "nonExistent")?.is.required().to.have.minLength(5).msgTooShort("should have at least 5 signs"),
                NGRPropertyValidator(property: "birthDate")?.to.be.earlierThan(Date()).msgNotEarlierThan("should happen in the past"),
                NGRPropertyValidator(property: "attachment")?.is.required().to.be.image().msgTooShort("should have at least 5 signs"),
            ].flatMap { $0 }
        }
        
        guard let errors = validationErrors else { return }
        
        print(errors)
        
        let message = errors.first?.localizedDescription
        let alert = UIAlertController(title: "Validation failed!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
