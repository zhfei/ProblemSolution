//
//  FilterViewController.swift
//  UITools
//
//  Created by zhoufei on 2024/11/21.
//

import UIKit

struct FilterModel {
    var title: String
    var selected: Bool = false
    
    mutating func updateSelected(state: Bool) {
        self.selected = state
    }
}

class FilterViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    let cellIdentifier = "FilterTableViewCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableWidth: NSLayoutConstraint!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableTop: NSLayoutConstraint!
    @IBOutlet weak var tableCenterX: NSLayoutConstraint!
    
    // 数据源
    lazy var items: [FilterModel] = {
        let list = [
            FilterModel(title: "Item 1"),
            FilterModel(title: "Item 2"),
            FilterModel(title: "Item 3"),
            FilterModel(title: "Item 4"),
            FilterModel(title: "Item 5")
        ]
        return list
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        setupLayout()
    }

    
    
    // MARK: - Private Method
    func setupUI() {
        
    }
    
    func setupLayout() {
        tableWidth.constant = 144
        tableHeight.constant = 44 * CGFloat(items.count)
        tableCenterX.constant = 100
        
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
    }
    
    // MARK: - Public Method
    class func filterViewController() -> FilterViewController {
        return FilterViewController(nibName: "FilterViewController", bundle: nil)
    }
    
    // MARK: - Event
    
    // MARK: - Delegate
    
    // UITableViewDataSource 方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= items.count {
            return UITableViewCell()
        }
        
        let cell: FilterTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilterTableViewCell
        cell.configUI(data: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for (index, _) in items.enumerated() {
            if index == indexPath.row {
                items[index].updateSelected(state: true)
            } else {
                items[index].updateSelected(state: false)
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Getter, Setter
    
    // MARK: - NSCopying
    
    // MARK: - NSObject
    
    // MARK: - Extension
    
}
