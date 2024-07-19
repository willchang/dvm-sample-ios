// Copyright © 2024 Flipp. All rights reserved.

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    let merchantLabel: UILabel = {
      let label = UILabel()
      label.text = "Merchant"
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let merchantTextField: UITextField = {
      let textField = UITextField()
      textField.placeholder = "Enter merchant"
      textField.text = "2271"
      textField.borderStyle = .roundedRect
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
    }()

    let storeCodeLabel: UILabel = {
      let label = UILabel()
      label.text = "Store Code"
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let storeCodeTextField: UITextField = {
      let textField = UITextField()
      textField.placeholder = "Enter store code"
      textField.text = "1009"
      textField.borderStyle = .roundedRect
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
    }()

    let loadPublicationsButton: UIButton = {
      let button = UIButton(type: .roundedRect)
      button.setTitle("Load Publications", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white

      setupViews()
      setupConstraints()

      // Add tap gesture to dismiss keyboard
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      view.addGestureRecognizer(tapGesture)
      loadPublicationsButton.addTarget(self, action: #selector(loadPublicationsButtonTapped), for: .touchUpInside)
    }

    func setupViews() {
      view.addSubview(merchantLabel)
      view.addSubview(merchantTextField)
      view.addSubview(storeCodeLabel)
      view.addSubview(storeCodeTextField)
      view.addSubview(loadPublicationsButton)

      merchantTextField.delegate = self
      storeCodeTextField.delegate = self
    }

    func setupConstraints() {
      NSLayoutConstraint.activate([
        merchantLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        merchantLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

        merchantTextField.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 8),
        merchantTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        merchantTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        storeCodeLabel.topAnchor.constraint(equalTo: merchantTextField.bottomAnchor, constant: 20),
        storeCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

        storeCodeTextField.topAnchor.constraint(equalTo: storeCodeLabel.bottomAnchor, constant: 8),
        storeCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        storeCodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        loadPublicationsButton.topAnchor.constraint(equalTo: storeCodeTextField.bottomAnchor, constant: 20),
        loadPublicationsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
    }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  @objc func loadPublicationsButtonTapped() {
    guard let merchant = merchantTextField.text, !merchant.isEmpty,
          let storeCode = storeCodeTextField.text, !storeCode.isEmpty else {
      let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }

    let publicationsViewController = PublicationsViewController()
    publicationsViewController.view.backgroundColor = .white
    publicationsViewController.title = "Publications"
    publicationsViewController.merchantID = merchant
    publicationsViewController.storeCode = storeCode
    navigationController?.pushViewController(publicationsViewController, animated: true)
  }
}