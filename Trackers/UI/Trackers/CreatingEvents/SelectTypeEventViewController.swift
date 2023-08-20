import UIKit

protocol SelectTypeEventViewControllerDelegate: AnyObject {
    func didTapSelectTypeEventButton(isRegular: Bool)
}

final class SelectTypeEventViewController: UIViewController {
    weak var delegate: NewTrackerViewControllerDelegate?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создание трекера"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var addRegularEventButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .trBlack
        button.setTitle("Привычка", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addIrregularEventButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .trBlack
        button.setTitle("Нерегулярные событие", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapIrregularEventButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraints()
    }
    
    @objc
    private func didTapHabitButton() {
        let createEventViewController = NewTrackerViewController(isRegular: true, isEditor: false)
        createEventViewController.delegate = delegate
        createEventViewController.modalPresentationStyle = .pageSheet
        present(createEventViewController, animated: true)
    }
    
    @objc
    private func didTapIrregularEventButton() {
        let createEventViewController = NewTrackerViewController(isRegular: false, isEditor: false)
        createEventViewController.delegate = delegate
        createEventViewController.modalPresentationStyle = .pageSheet
        present(createEventViewController, animated: true)
    }

    private func setLayout() {
        view.backgroundColor = .trWhite
        [titleLabel, addRegularEventButton, addIrregularEventButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            addRegularEventButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 295),
            addRegularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addRegularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addRegularEventButton.heightAnchor.constraint(equalToConstant: 60),
            
            addIrregularEventButton.topAnchor.constraint(equalTo: addRegularEventButton.bottomAnchor, constant: 16),
            addIrregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addIrregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addIrregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//import UIKit
//import SnapKit
//
//protocol TypeNewTrackerDelegate: AnyObject {
//    func didTapSelectTypeEventButton(isRegular: Bool)
//
//}
//
//final class TypeNewTrackerViewController: UIViewController {
//    weak var delegate: NewTrackerViewControllerDelegate?
//
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        label.textColor = .trBlack
//        label.text = "Создание трекера"
//        return label
//    }()
//
//    private let verticalStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        return stackView
//    }()
//
//    private lazy var newHabitButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Привычка", for: .normal)
//        button.setTitleColor(.trWhite, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.backgroundColor = .trBlack
//        button.layer.cornerRadius = 16
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(newHabitButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var newEventButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Нерегулярные событие", for: .normal)
//        button.setTitleColor(.trWhite, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.backgroundColor = .trBlack
//        button.layer.cornerRadius = 16
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(newEventButtonTapped), for: .touchUpInside)
//
//        return button
//    }()
//
//    init(categories: [TrackerCategory]) {
//        self.categories = categories
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .trWhite
//
//        addSubviews()
//        addConstraints()
//    }
//
//    private func addSubviews() {
//        [titleLabel, verticalStackView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//
//        [newHabitButton, newEventButton].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            verticalStackView.addArrangedSubview($0)
//        }
//    }
//
//    private func addConstraints() {
//
//        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(view.snp.top).offset(40)
//        }
//
//        newHabitButton.snp.makeConstraints { make in
//            make.height.equalTo(60)
//        }
//
//        newEventButton.snp.makeConstraints { make in
//            make.height.equalTo(newHabitButton)
//        }
//
//        verticalStackView.snp.makeConstraints { make in
//            make.leading.equalTo(view).offset(20)
//            make.trailing.equalTo(view).offset(-20)
//            make.centerY.equalTo(view)
//        }
//
//    }
//
//    @objc private func newHabitButtonTapped() {
//        let newTrackerVC = NewTrackerViewController()
//        newTrackerVC.typeOfNewTracker = .habitTracker
//        newTrackerVC.delegate = self
//        present(newTrackerVC, animated: true)
//    }
//
//    @objc private func newEventButtonTapped() {
//        let newTrackerVC = NewTrackerViewController()
//        newTrackerVC.typeOfNewTracker = .eventTracker
//        newTrackerVC.delegate = self
//        present(newTrackerVC, animated: true)
//    }
//}
//
//extension TypeNewTrackerViewController: NewTrackerViewControllerDelegate {
//    func addNewTrackerCategory(_ newTrackerCategory: TrackerCategory) {
//        delegate?.addNewTrackerCategory(newTrackerCategory)
//        dismiss(animated: true)
//    }
//}
