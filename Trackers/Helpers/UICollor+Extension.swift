import UIKit

extension UIColor {
    static var ypBlackDay: UIColor { UIColor(named: "BlackDay")! }
    static var ypBlacNight: UIColor { UIColor(named: "BlackNight")! }
    static var ypWhiteDay: UIColor { UIColor(named: "WhiteDay")! }
    static var ypWhiteNight: UIColor { UIColor(named: "WhiteNight")! }
    static var ypGray: UIColor { UIColor(named: "Gray")! }
    static var ypLightGray: UIColor { UIColor(named: "LightGray")! }
    static var ypRed: UIColor { UIColor(named: "Red")! }
    static var ypBlue: UIColor { UIColor(named: "Blue")! }
    static var ypBackgroundDay: UIColor { UIColor(named: "BackgroundDay")! }
    static var ypBackgroundNight: UIColor { UIColor(named: "BackgroundNight")! }
    
    static var section1: UIColor { UIColor(named: "Color selection 1")! }
    static var section2: UIColor { UIColor(named: "Color selection 2")! }
    static var section3: UIColor { UIColor(named: "Color selection 3")! }
    static var section4: UIColor { UIColor(named: "Color selection 4")! }
    static var section5: UIColor { UIColor(named: "Color selection 5")! }
    static var section6: UIColor { UIColor(named: "Color selection 6")! }
    static var section7: UIColor { UIColor(named: "Color selection 7")! }
    static var section8: UIColor { UIColor(named: "Color selection 8")! }
    static var section9: UIColor { UIColor(named: "Color selection 9")! }
    static var section10: UIColor { UIColor(named: "Color selection 10")! }
    static var section11: UIColor { UIColor(named: "Color selection 11")! }
    static var section12: UIColor { UIColor(named: "Color selection 12")! }
    static var section13: UIColor { UIColor(named: "Color selection 13")! }
    static var section14: UIColor { UIColor(named: "Color selection 14")! }
    static var section15: UIColor { UIColor(named: "Color selection 15")! }
    static var section16: UIColor { UIColor(named: "Color selection 16")! }
    static var section17: UIColor { UIColor(named: "Color selection 17")! }
    static var section18: UIColor { UIColor(named: "Color selection 18")! }
    
    static func hexString(from color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }

    static func color(from hex: String) -> UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
