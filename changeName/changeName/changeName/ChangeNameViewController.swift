import UIKit
import Combine
import CombineCocoa

class ChangeNameViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ChangeNameViewModel()
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setUpSaveButton()
        setUpInitialTextFieldValues()
        setUpTextFieldSubscriptions()
        setUpValidationSubscription()
    }
    @IBAction private func saveButtonPressed(_ sender: UIButton) {
        viewModel.saveChanges()
        view.endEditing(true)
        showAlert()
    }
}

// MARK: - Setup
extension ChangeNameViewController {
    private func setUpViewModel() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.user.rawValue)
        viewModel.setUpDefaultUser()
    }
    private func setUpSaveButton() {
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2
    }
    private func setUpInitialTextFieldValues() {
        firstNameTextField.text = viewModel.user.firstName
        lastNameTextField.text = viewModel.user.lastName
    }
    private func setUpTextFieldSubscriptions() {
        firstNameTextField.textPublisher
            .combineLatest(lastNameTextField.textPublisher)
            .receive(on: DispatchQueue.main)
            .print()
            .sink(receiveValue: { [weak self] firstname, lastname in
                guard let self = self else { return }
                self.viewModel.user.firstName = firstname!
                self.viewModel.user.lastName = lastname!
                self.viewModel.validateNewValues()
            })
            .store(in: &subscriptions)
    }
    private func setUpValidationSubscription() {
        viewModel.hasPassedValidationSubject
            .receive(on: DispatchQueue.main)
            .print()
            .sink(receiveValue: { [weak self] status in
                guard let self = self else { return }
                self.saveButton.isEnabled = status
                self.refreshSaveButtonBackgroundColor()
            })
            .store(in: &subscriptions)
    }
}

// MARK: - UITextFieldDelegate
extension ChangeNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Helpers
extension ChangeNameViewController {
    private func refreshSaveButtonBackgroundColor() {
        if saveButton.isEnabled {
            saveButton.backgroundColor = .blue
        } else {
            saveButton.backgroundColor = .gray
        }
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Your name has been changed", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
