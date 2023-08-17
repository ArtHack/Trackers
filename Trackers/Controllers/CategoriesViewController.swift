import UIKit
import SnapKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func didSelectCategory(with name: String?)
}

final class CategoriesViewController: UIViewController {
    private var heightTableView: Int = -1
    private var tableViewHeightConstraint: NSLayoutConstraint?

    weak var delegate: CategoriesViewControllerDelegate?
    var viewModel: CategoriesViewModel

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .trBlack
        label.text = "Категория"

        return label
    }()

    private lazy var emptyCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")

        return imageView
    }()

    private lazy var emptyCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Привычки и события можно объединить по смыслу"
        label.numberOfLines = 2
        label.textColor = .trBlack
        label.textAlignment = .center

        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .trGray
        tableView.backgroundColor = .trWhite
        tableView.alwaysBounceVertical = false
        tableView.bounces = false

        return tableView
    }()

    private lazy var addCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить категорию", for: .normal)
        button.setTitleColor(.trWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .trBlack
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addCategoryButtonTapped), for: .touchUpInside)

        return button
    }()

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$selectedCategoryName.bind { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didSelectCategory(with: self.viewModel.selectedCategoryName)
            self.tableView.reloadData()
        }

        viewModel.$categories.bind { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.categories?.count != 0 {
                self.tableView.isHidden = false
                self.emptyCategoryLabel.isHidden = true
                self.emptyCategoryImageView.isHidden = true
            } else {
                self.tableView.isHidden = true
                self.emptyCategoryLabel.isHidden = false
                self.emptyCategoryImageView.isHidden = false
            }

            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableViewHeightConstraint?.constant = self.tableView.contentSize.height - 1
            }
        }

        viewModel.$alertModel.bind { [weak self] alertModel in
            guard let self, let alertModel else { return }
            AlertPresenter().showAlert(controller: self, model: alertModel)
        }

        if let categories = viewModel.categories, categories.count != 0 {
           heightTableView = categories.count * 75 - 1
           emptyCategoryLabel.isHidden = true
           emptyCategoryImageView.isHidden = true
        }

        view.backgroundColor = .trWhite

        addSubviews()
        addConstraints()

        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightTableView))
        tableViewHeightConstraint?.priority = .defaultLow
        tableViewHeightConstraint?.isActive = true
    }

    @objc private func addCategoryButtonTapped() {
        let newCategoryVC = NewCategoryViewController()
        newCategoryVC.delegate = self
        present(newCategoryVC, animated: true)
    }

    private func editCategory(_ category: TrackerCategory) {
        let newCategoryVC = NewCategoryViewController()
        newCategoryVC.delegate = self
        newCategoryVC.editingCategory = category

        present(newCategoryVC, animated: true)
    }

    private func addSubviews() {
        [titleLabel, emptyCategoryImageView, emptyCategoryLabel, tableView, addCategoryButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

    }

    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.top).offset(40)
        }

        emptyCategoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
        }

        emptyCategoryImageView.snp.makeConstraints { make in
            make.bottom.equalTo(emptyCategoryLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(73)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.bottom.lessThanOrEqualTo(addCategoryButton.snp.top).offset(-16)
        }

        addCategoryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(60)
        }
    }

}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
              let categoryName = cell.textLabel?.text else { return }
        viewModel.selectCategory(with: categoryName)

        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let category = viewModel.categories?[indexPath.row] else { return nil }

        return UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(children: [
                UIAction(title: "Редактировать") { [weak self] _ in
                    self?.editCategory(category)
                },
                UIAction(title: "Удалить", attributes: .destructive) { [weak self] _ in
                    self?.viewModel.showAlertToDelete(category)
                }
            ])
        })
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.categories?.count ?? 0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .trBackground
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.categories?[indexPath.row].title
        cell.accessoryType = cell.textLabel?.text == viewModel.selectedCategoryName ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension CategoriesViewController: NewCategoryViewControllerDelegate {
    func create(newCategory: String?) {
        viewModel.addNewCategory(with: newCategory)
    }

    func update(editingCategory: String, with editedCategory: String) {
        viewModel.editCategory(from: editingCategory, with: editedCategory)
    }
}
