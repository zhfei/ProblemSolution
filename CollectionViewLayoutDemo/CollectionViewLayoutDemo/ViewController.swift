//
//  ViewController.swift
//  CollectionViewLayoutDemo
//
//  Created by zhoufei on 2025/4/1.
//

import UIKit

class ViewController: UIViewController {
    
    // 数据源 - 不同长度的文本
    private let items = [
        "短文本",
        "这是一个中等长度的文本",
        "这是一个较长的文本内容，用来测试自动布局和手动布局的区别",
        "非常长的文本内容测试，这段文字会比较长，测试自动布局情况下的换行效果以及手动布局情况下可能出现的截断问题",
        "短",
        "中等文本示例",
        "另一个长文本示例，用于展示自动布局的换行功能"
    ]
    
    // 左侧 CollectionView - 自动布局
    private lazy var autoLayoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AutoSizingCell.self, forCellWithReuseIdentifier: "AutoSizingCell")
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        return collectionView
    }()
    
    // 右侧 CollectionView - 手动布局
    private lazy var fixedSizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // 手动布局不设置 estimatedItemSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FixedSizeCell.self, forCellWithReuseIdentifier: "FixedSizeCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        return collectionView
    }()
    
    // 上方标题标签
    private lazy var autoLayoutLabel: UILabel = {
        let label = UILabel()
        label.text = "自动布局"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fixedSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "手动布局"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // 添加标题标签
        view.addSubview(autoLayoutLabel)
        view.addSubview(fixedSizeLabel)
        
        // 添加 CollectionView
        view.addSubview(autoLayoutCollectionView)
        view.addSubview(fixedSizeCollectionView)
        
        // 设置约束
        NSLayoutConstraint.activate([
            // 自动布局标签
            autoLayoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            autoLayoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            autoLayoutLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            // 固定大小标签
            fixedSizeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            fixedSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fixedSizeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            // 自动布局 CollectionView
            autoLayoutCollectionView.topAnchor.constraint(equalTo: autoLayoutLabel.bottomAnchor, constant: 10),
            autoLayoutCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            autoLayoutCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.47),
            autoLayoutCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            // 固定大小 CollectionView
            fixedSizeCollectionView.topAnchor.constraint(equalTo: fixedSizeLabel.bottomAnchor, constant: 10),
            fixedSizeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            fixedSizeCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.47),
            fixedSizeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == autoLayoutCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoSizingCell", for: indexPath) as! AutoSizingCell
            cell.configure(with: items[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FixedSizeCell", for: indexPath) as! FixedSizeCell
            cell.configure(with: items[indexPath.item])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 仅为固定尺寸的 CollectionView 设置固定尺寸
        if collectionView == fixedSizeCollectionView {
            // 手动设置每个 cell 的尺寸 (固定宽度，高度根据内容长度有所调整)
            return CGSize(width: collectionView.bounds.width - 20, height: 60)
        }
        
        // 自动布局的 CollectionView 不在这里设置尺寸，由 cell 自行决定
        return CGSize.zero
    }
}

// MARK: - 自动布局 Cell
class AutoSizingCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 8
        
        label.numberOfLines = 0 // 允许多行
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        // 设置约束，关键是水平和垂直方向都有约束
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // 预计尺寸，用于 UICollectionViewFlowLayout.automaticSize
    //cell单元格提供给layout它的布局属性，用于在布局流水中进行布局
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        //自动布局下，系统尺寸最佳适配
        let size = contentView.systemLayoutSizeFitting(targetSize,
                                                       withHorizontalFittingPriority: .required,
                                                       verticalFittingPriority: .fittingSizeLevel)
        attributes.frame.size = size
        return attributes
    }
    
    func configure(with text: String) {
        label.text = text
    }
}

// MARK: - 固定尺寸 Cell
class FixedSizeCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 8
        
        label.numberOfLines = 2 // 限制行数
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with text: String) {
        label.text = text
    }
}
