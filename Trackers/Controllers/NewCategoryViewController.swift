import UIKit

protocol NewCategoryViewControllerDelegate: AnyObject {
    func create(newCategory: String?)
    func update(editingCategory: String, with editedCategory: String)
}

final class NewCategoryViewController: UIViewController {
    weak var delegate: NewCategoryViewControllerDelegate?
    var editingCategory: TrackerCategory?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .trBlack
        label.text = "Новая категория"

        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название категории"
        let leftInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        textField.leftView = leftInsetView
        textField.leftViewMode = .always
        textField.backgroundColor = .trBackground
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.delegate = self

        return textField
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .trGray
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .trWhite
        textField.delegate = self

        textField.text = editingCategory?.title

        addSubviews()
        addConstraints()
    }

    @objc private func doneButtonTapped() {
        if textField.hasText {
            if let category = textField.text {
                if editingCategory == nil {
                    delegate?.create(newCategory: category)
                } else if let editingCategory = editingCategory {
                    delegate?.update(editingCategory: editingCategory.title, with: category)
                    self.editingCategory = nil
                }
                dismiss(animated: true)
            }
        }
    }

    private func addSubviews() {
        [titleLabel, textField, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.top).offset(40)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(75)
            make.width.equalTo(view).offset(-32)
        }

        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(60)
        }
    }

}

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        } else if textField.text?.isEmpty == true && !string.isEmpty {
            doneButton.backgroundColor = .trBlack
            doneButton.setTitleColor(.trWhite, for: .normal)
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            doneButton.backgroundColor = .trGray
            doneButton.setTitleColor(.trWhite, for: .normal)
        }
    }
}
