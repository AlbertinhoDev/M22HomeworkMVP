import Foundation
import UIKit
import SnapKit

class CellLabelAndImage: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageViewCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(imageViewCell)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageViewCell.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).inset(10)
            make.left.equalTo(contentView.snp.leftMargin).inset(0)
            make.bottom.equalTo(contentView.snp.bottomMargin).inset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).inset(0)
            make.left.equalTo(imageViewCell.snp.rightMargin).inset(-20)
            make.right.equalTo(contentView.snp.rightMargin).inset(10)
            make.bottom.equalTo(contentView.snp.bottomMargin).inset(0)
        }
        
    }
    
}
