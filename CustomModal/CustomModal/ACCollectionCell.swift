//
//  ACCollectionCell.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/24.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACCollectionCell: UICollectionViewCell {
    weak var imgView: UIImageView!
    let titleLabel: UILabel!
    
    var thing: ACModel? {
        didSet {
            imgView.image = thing!.image
            titleLabel.text = thing!.title
        }
    }
    
    override init(frame: CGRect) {
        let imgView = UIImageView()
        self.imgView = imgView
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        super.init(frame: frame)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imgView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width)
        titleLabel.frame = CGRect(x: 0, y: imgView.frame.maxY, width: self.bounds.width, height: self.bounds.height - self.bounds.width)
        super.layoutSubviews()
    }

}
