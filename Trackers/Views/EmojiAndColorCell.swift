import UIKit
import SnapKit

final class EmojiAndColorsCollectionCell: UICollectionViewCell {
    static var reuseIdentifier = "EmojiAndColorsCollectionCell"
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
    }
}

