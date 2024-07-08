import UIKit

public class TabBarController: UITabBarController {

    // MARK: Properties

    private let indicatorPlatform = UIView()

    // MARK: Init

    public override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        setupUI()
        setViewControllers()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let firstItem = tabBar.items?[0],
              let firstItem = firstItem as? TabBarItem,
              let firstItemColor = firstItem.tintColor else {
            return
        }

        tabBar.tintColor = firstItemColor
        indicatorPlatform.backgroundColor = firstItemColor
        indicatorPlatform.layer.cornerRadius = 2
    }

    private func setupUI() {
        self.tabBar.layer.masksToBounds = false
        self.tabBar.isTranslucent = false
        self.delegate = self
        self.tabBar.barStyle = .default
        tabBar.tintColor = #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1)
        self.tabBar.backgroundImage = UIImage(named: "tabBar-background")
        self.tabBar.backgroundColor = #colorLiteral(red: 0.03927257657, green: 0.2510837018, blue: 0.3500892818, alpha: 1)
        self.tabBar.shadowColor = .Background
        self.tabBar.unselectedItemTintColor = .white

        let notificationsButton = UIBarButtonItem(image: UIImage(named: "notifications"), style: .plain, target: self, action: #selector(notificationAction))
        navigationItem.rightBarButtonItem = notificationsButton
    }

    @objc func notificationAction() {
        // Implement notification action
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let items = tabBar.items, items.count > 2 {
            let middleIndex = items.count / 2
            let middleItem = items[middleIndex]
            if let imageView = middleItem.value(forKey: "view") as? UIView {
                imageView.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y - 10, width: imageView.frame.width, height: imageView.frame.height + 10)
                // Set the search icon to be larger and not affected by tint
                if middleIndex == 2 {
                    middleItem.image = middleItem.image?.withRenderingMode(.alwaysOriginal)
                    middleItem.selectedImage = middleItem.selectedImage?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }

    private func setViewControllers() {
        let homeViewController = HomeViewController.loadFromNib()
        homeViewController.tabBarItem = TabBarItem(title: "الرئيسية", image: UIImage(named: "home"), tag: 0, tintColor: #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1))
        homeViewController.tabBarItem.selectedImage = UIImage(named: "home")

        let phoneViewController = TestViewController.loadFromNib()
        phoneViewController.tabBarItem = TabBarItem(title: "اتصل بنا", image: UIImage(named: "phone"), tag: 1, tintColor: #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1))
        phoneViewController.tabBarItem.selectedImage = UIImage(named: "phone")

        let searchViewController = TestViewController.loadFromNib()
        searchViewController.tabBarItem = TabBarItem(title: "", image: UIImage(named: "search"), tag: 2, tintColor: #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1))
        searchViewController.tabBarItem.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: 6, right: 0)
        searchViewController.tabBarItem.selectedImage = UIImage(named: "search")

        let cartViewController = TestViewController.loadFromNib()
        cartViewController.tabBarItem = TabBarItem(title: "مشترياتي", image: UIImage(named: "cart"), tag: 3, tintColor: #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1))
        cartViewController.tabBarItem.selectedImage = UIImage(named: "cart")

        let profileViewController = TestViewController.loadFromNib()
        profileViewController.tabBarItem = TabBarItem(title: "حسابي", image: UIImage(named: "profile"), tag: 4, tintColor: #colorLiteral(red: 0.9803921569, green: 0.7725490196, blue: 0.4, alpha: 1))
        profileViewController.tabBarItem.selectedImage = UIImage(named: "profile")

        self.viewControllers = [homeViewController, phoneViewController, searchViewController, cartViewController, profileViewController]
    }

    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        // setupIndicatorPlatform()
    }

    // MARK: UITabBarDelegate

    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var tabBars = _isRTL ? tabBar.items!.reversed() : tabBar.items!

        let index = CGFloat(integerLiteral: tabBars.firstIndex(of: item)!)
        let itemWidth = indicatorPlatform.frame.width
        let newCenterX = (itemWidth / 2.0) + (itemWidth * index)

        UIView.animate(withDuration: 0.3) {
            if let tabBarItem = item as? TabBarItem,
               let tabBarItemColor = tabBarItem.tintColor {
                tabBar.tintColor = tabBarItemColor
            }
            self.indicatorPlatform.backgroundColor = tabBar.tintColor
            self.indicatorPlatform.center.x = newCenterX
        }

        updateIndicatorPlatform(forIndex: Int(index))
    }

    // MARK: Private Functions

    private func setupIndicatorPlatform() {
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        indicatorPlatform.backgroundColor = tabBar.tintColor
        indicatorPlatform.frame = CGRect(x: 0.0, y: 0.0, width: tabBarItemSize.width, height: 2.0)
        indicatorPlatform.center.x = _isRTL ? tabBar.frame.width - tabBarItemSize.width / 2 : tabBar.frame.width / CGFloat(tabBar.items!.count) / 2.0
        tabBar.addSubview(indicatorPlatform)
    }

    func updateIndicatorPlatform(forIndex index: Int) {
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        let newCenterX = (tabBarItemSize.width / 2.0) + (tabBarItemSize.width * CGFloat(index))

        UIView.animate(withDuration: 0.3) {
            self.indicatorPlatform.center.x = newCenterX
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
