//
//  CustomTableViewCell.swift
//  BookmarkUIKit
//
//  Created by Leyla Nyssanbayeva on 23.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    private let customView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let title: UILabel = {
        let textTitle = UILabel()
        textTitle.numberOfLines = 1
        textTitle.text = ""
        textTitle.textColor = .black
        textTitle.font = .systemFont(ofSize: 17, weight: .regular)
        return textTitle
    }()
    
    private let iconImage: UIImage = {
        return UIImage(named: "link.png") ?? (UIImage(systemName: "link") ?? UIImage())
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.top.equalToSuperview().inset(1)
            make.height.equalTo(74)
        }
        
        customView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(11)
        }
        
        let image = UIImageView(image: iconImage)
        customView.addSubview(image)
        image.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(11)
        }
        
    }
    
    func configure(title: String) {
        self.title.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
