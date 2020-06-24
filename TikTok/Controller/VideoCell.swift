//
//  VideoCell.swift
//  TikTok
//
//  Created by Mac on 2020/6/22.
//  Copyright © 2020 Kxy. All rights reserved.
//

import UIKit
import MarqueeLabel
import Kingfisher
import ChainableAnimations

class VideoCell: UITableViewCell {
    
    var addBtnAnimator : ChainableAnimator!
    var coverAnimator : ChainableAnimator!
    
    var aweme : AwemeList! {
        didSet{
            labelAuthor.text = aweme.author!.nickname
            labelDes.text = aweme.desc!
            coverImageView.kf.setImage(with: URL(string: aweme.video!.cover!.urlList![0]))
            
            labelMusic.text = aweme.music!.title! + "-" + aweme.music!.author!
            labelMusic.restartLabel()
            
            likeLab.text = aweme.statistics!.diggCount!.toWanStr
            commentNum.text = aweme.statistics!.commentCount!.toWanStr
            shareNum.text = aweme.statistics!.shareCount!.toWanStr
            
            authorDetail.imageView?.layer.cornerRadius = 25
            authorDetail.kf.setImage(with: URL(string: aweme.author!.avatarThumb!.urlList![0]), for: [])
            
            addToFollow.layer.cornerRadius = 10
            addToFollow.clipsToBounds = true
            
            musicCoverImageView.kf.setImage(with: URL(string: aweme.music!.coverThumb!.urlList![0]))
            musicCoverImageView.layer.cornerRadius = 12
            
            coverAnimator = ChainableAnimator(view: subDisview)
            coverAnimator.rotate(angle: 180)
                .animateWithRepeat(t: 3, count: 10000)
            
            //音符散发动画
            diskView.raiseAnimate(imageName: "icon_home_musicnote1", delay: 0)
            diskView.raiseAnimate(imageName: "icon_home_musicnote2", delay: 1)
            diskView.raiseAnimate(imageName: "icon_home_musicnote1", delay: 2)
        }
        
    }

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var puseImageView: UIImageView!
    
    @IBOutlet weak var labelAuthor: UILabel!
    
    @IBOutlet weak var labelDes: UILabel!
    
    @IBOutlet weak var labelMusic: MarqueeLabel!
    
    @IBOutlet weak var authorDetail: UIButton!
    @IBOutlet weak var addToFollow: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeLab: UILabel!
    
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareNum: UILabel!
    
    @IBOutlet weak var diskView: UIView!
    @IBOutlet weak var subDisview: UIView!
    @IBOutlet weak var musicCoverImageView: UIImageView!
    @IBOutlet weak var rotateDisView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        //重置单元格
        super.prepareForReuse()
        diskView.resetViewAnimation()
        if self.addBtnAnimator != nil {
            self.addBtnAnimator.stop()
            self.addToFollow.transform = .identity
            //去掉layer层的动画
            self.addToFollow.layer.removeAllAnimations()
            self.addToFollow.setImage(UIImage(named: "icon_personal_add_little"), for: [])
        }
        
        if self.coverAnimator != nil {
            debugPrint("准备")
            self.coverAnimator.stop()
            self.subDisview.layer.removeAllAnimations()
            self.subDisview.transform = .identity
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFollow(_ sender: UIButton) {
        addBtnAnimator = ChainableAnimator(view: sender)
        UIView.transition(with: sender, duration: 0.1, options: .transitionCrossDissolve) {
            sender.setImage(UIImage(named: "iconSignDone"), for: [])
        } completion: { (_) in
            self.addBtnAnimator.rotate(angle: 360)
                .thenAfter(t: 0.2)
                .wait(t: 0.2)
                .transform(scale: 0)
                .animate(t: 0.2)
            
        }

        
    }
    
}
