import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    var page: Pages
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: String(page.index))
        imageView.image = image
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = page.title
        label.textColor = .trBlack
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    init(with page: Pages) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        [imageView, titleLabel].forEach {
            view.addSubview($0)
        }
    }

    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset(26)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
        }
    }
}
