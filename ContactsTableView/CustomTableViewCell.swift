//
//  CustomTableViewCell.swift
//  ContactsTableView
//
//  Created by Candy on 2017/5/9.
//  Copyright © 2017年 CandyHu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // 將自訂Cell 上的元件拉IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 設定照片的圓弧
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2
        photoImageView.layer.masksToBounds = true
    }
    
}
