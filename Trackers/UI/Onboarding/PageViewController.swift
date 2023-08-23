import UIKit
import SnapKit

final class PageViewController: UIPageViewController {
    private var pages: [Pages] = Pages.allCases
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
       return pageControl
    }()
    
    private lazy var onboardingButton: UIButton = {
       let button = UIButton()
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(onboardingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        setupPageController()
    }
    
    @objc
    private func onboardingButtonTapped() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    private func setupPageController() {
        dataSource = self
        delegate = self
        let initialVC = OnboardingViewController(with: pages[0])
        setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        [pageControl, onboardingButton].forEach {
            view.addSubview($0)
        }
    }

    private func addConstraints() {
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(onboardingButton.snp.top).offset(-24)
            make.centerX.equalToSuperview()
        }
        
        onboardingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-84)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
    }
}

// MARK: - UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first as? OnboardingViewController {
            pageControl.currentPage = currentViewController.page.index
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController else { return nil }
        var index = currentVC.page.index
        if index == 0 {
            return nil
        }
        
        index -= 1
        let vc = OnboardingViewController(with: pages[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController else { return nil }
        var index = currentVC.page.index
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        let vc = OnboardingViewController(with: pages[index])
        
        return vc
    }
}
