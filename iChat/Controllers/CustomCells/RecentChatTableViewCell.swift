//
//  RecentChatTableViewCell.swift
//  iChat
//
//  Created by Jacob Rozell on 9/4/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit

protocol RecentChatTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath)
}

class RecentChatTableViewCell: UITableViewCell {
    
    static let reuse = "recentCell"

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageCounterLabel: UILabel!
    @IBOutlet weak var messageCounterBackgroundView: UIView!
    
    var indexPath: IndexPath!
    let tapGesture = UITapGestureRecognizer()
    var delegate: RecentChatTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageCounterBackgroundView.layer.cornerRadius = messageCounterBackgroundView.frame.width / 2
        messageCounterBackgroundView.clipsToBounds = true
        
        tapGesture.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: Generate Cell
    func generateCell(recentChat: NSDictionary, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.nameLabel.text = (recentChat[Constants.WITHUSERFULLNAME] as? String)?.capitalized
        self.lastMessageLabel.text = recentChat[Constants.LASTMESSAGE] as? String
        self.messageCounterLabel.text = recentChat[Constants.COUNTER] as? String
        
        if let avatarString = recentChat[Constants.AVATAR] {
            imageFromData(pictureData: avatarString as! String) { (avatar) in
                if avatar != nil {
                    self.avatarImageView.image = avatar!.circleMasked
                }
            }
        }
        
        let counter = recentChat[Constants.COUNTER] as! Int
        if counter != 0 {
            self.messageCounterLabel.text = "\(counter)"
            self.messageCounterBackgroundView.isHidden = false
            self.messageCounterLabel.isHidden = false
        } else {
            self.messageCounterBackgroundView.isHidden = true
            self.messageCounterLabel.isHidden = true
        }
        
        var date = Date()
        
        if let created = recentChat[Constants.DATE] {
            if (created as! String).count == 14 {
                date = dateFormatter().date(from: created as! String) ?? Date()
            }
        }
        
        self.dateLabel.text = timeElapsed(date: date)
    }
    
    @objc func avatarTap() {
         delegate?.didTapAvatarImage(indexPath: indexPath)
    }
}
