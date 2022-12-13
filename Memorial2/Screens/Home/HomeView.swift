//
//  
//  HomeView.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapButton(_ text: String)
}

protocol HomeViewProtocol {
    var delegate: HomeViewDelegate? { get set }
    var view: UIView { get }

    func getNumberOfButtons() -> String
    func setupRecordLabel(_ record: Int)
}

final class HomeView: HomeViewProtocol {
    var delegate: HomeViewDelegate?
    var view = UIView()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "BEM VINDO(A)!"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione a quantidade de botões para começar o jogo: "
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var inputTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .numberPad
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("COMEÇAR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeLabel, recordLabel, infoLabel, inputTextField, startButton])
        stack.spacing = 32
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init() {
        view.backgroundColor = .white
        view.addSubview(contentStack)
        addViews()
        setupKeyboard()
    }

    private func addViews() {
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func didTapButton() {
        delegate?.didTapButton(getNumberOfButtons())
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func getNumberOfButtons() -> String {
        guard let text = inputTextField.text else { return "" }
        return text
    }

    func setupRecordLabel(_ record: Int) {
        recordLabel.text = "O record atual é: \(record)"
    }
}
