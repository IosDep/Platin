import UIKit

class LoadingSkeletonView: UIView {
    private var isLoading = false
    private var label: UILabel?
    private var view: UIView?

    enum SkeletonType {
        case label
        case view
    }

    init(frame: CGRect, type: SkeletonType? = nil) {
        super.init(frame: frame)
        if type == .label {
            setupLabelSkeleton()
        } else {
            setupViewSkeleton()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // By default, use the view type
        setupViewSkeleton()
    }

    private func setupLabelSkeleton() {
        label = UILabel()
        label?.frame = bounds
        label?.text = "Loading..."
        label?.textColor = .lightGray
        label?.font = UIFont.systemFont(ofSize: 16)
        label?.textAlignment = .center
        addSubview(label!)

        // Add placeholder animation, e.g., shimmer effect
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = label!.frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.2, 0.5, 0.8]

        layer.addSublayer(gradientLayer)

        // Start animation
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = bounds.width * 2
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }

    private func setupViewSkeleton() {
        // Customize the view's appearance
        backgroundColor = #colorLiteral(red: 0.192, green: 0.243, blue: 0.396, alpha: 1)
        layer.cornerRadius = 8

        // Add placeholder animation, e.g., shimmer effect
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: -frame.width, y: 0, width: 3 * frame.width, height: frame.height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.2, 0.5, 0.8]

        layer.addSublayer(gradientLayer)

        // Start animation
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = bounds.width * 2
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }

    func startLoading() {
        isLoading = true
        isHidden = false
    }

    func stopLoading() {
        isLoading = false
        isHidden = true
    }

    func setText(_ text: String) {
        label?.text = text
    }

    func addCustomSubview(_ customView: UIView) {
        view = customView
        addSubview(customView)
    }
}
