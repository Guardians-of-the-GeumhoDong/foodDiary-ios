//
//  MainTableViewCell.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/12.
//

import UIKit
import Kingfisher

class TimelineTableViewCell: UITableViewCell {
    
    var postId : Int?

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func updateCell(data : TimelineModel) {
        
        let url = URL(string: NetworkDTO().getImageURL(url: data.imagesURL![0]))
        postImage.kf.setImage(with: url)
        dateLabel.text = data.createTime
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        self.postId = data.id
    }
    
}
