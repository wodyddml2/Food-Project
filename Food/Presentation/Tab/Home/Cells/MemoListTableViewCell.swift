//
//  MemoListTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

final class MemoListTableViewCell: BaseTableViewCell {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.register(MemoListCollectionViewCell.self, forCellWithReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let moreLabel: UILabel = {
        let view = UILabel()
        view.text = "더보기"
        view.font = .gothicNeo(.SemiBold, size: 14)
        return view
    }()
    
    let rightImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    
    var moreButton = UIButton()

    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        [collectionView,moreLabel,rightImageView,moreButton].forEach {
            contentView.addSubview($0)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(4)
            make.trailing.equalTo(-8)
            make.height.equalTo(14)
            make.width.equalTo(11)
        }
        moreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rightImageView)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-4)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(rightImageView.snp.trailing)
            make.leading.equalTo(moreLabel.snp.leading)
            make.top.bottom.equalTo(rightImageView)
        }
        
    }
    
    func itemHidden(color: UIColor, hidden: Bool) {
        backgroundColor = color
        moreButton.isHidden = hidden
        rightImageView.isHidden = hidden
        moreLabel.isHidden = hidden
    }
}
