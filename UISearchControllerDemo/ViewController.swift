//
//  ViewController.swift
//  UISearchControllerDemo
//
//  Created by Trista on 2021/2/6.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    //建立四個屬性
    var tableView: UITableView!
    var searchController: UISearchController!
    //記錄全部原始的資料
    let cities = [
            "臺北市","新北市","桃園市","臺中市","臺南市",
            "高雄市","基隆市","新竹市","嘉義市","新竹縣",
            "苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣",
            "屏東縣","宜蘭縣","花蓮縣","臺東縣","澎湖縣",]
    //隨搜尋文字不同，篩選出來的資料
    //屬性觀察器(property observer)會監控和回應屬性值的變化，每次屬性被設置新的值都會呼叫屬性觀察器
    var searchArr: [String] = [String](){
        //didSet：在新的值被設置之後立即呼叫，會將舊的屬性值當做參數傳入，這個參數可以自己命名，或直接使用內建的參數名稱oldValue
        didSet {
            //當資料有更新時,重設 searchArr 後重整 tableView
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        //使用 UITableView 來配合搜尋結果
        //建立 UITableView 並設置原點及尺寸
        self.tableView = UITableView(frame: CGRect(
          x: 0, y: 20,
          width: fullScreenSize.width,
          height: fullScreenSize.height - 20),
          style: .plain)
        
        //當 cell 數量超過一個畫面可顯示時，目前存在的 cell 只有畫面上的這些，當上下滑動時，會隨顯示畫面的不同同時移出並加入 cell，這個動作不是一直建立新的 cell 而是會重複使用( reuse )，所以必須先註冊這個 reuse 的 cell ，辨識名稱設為"Cell"，來讓後續顯示時可以使用
        //註冊 cell
        self.tableView.register(UITableViewCell.self,
          forCellReuseIdentifier: "Cell")
        
        //UITableView 有設置委任對象-self:ViewController
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //加入到畫面中
        self.view.addSubview(self.tableView)
        
        
        //建立 UISearchController 並設置搜尋控制器為 nil
        self.searchController =
          UISearchController(searchResultsController: nil)

        //UISearchController 也同樣設置更新搜尋結果的對象-self:ViewController
        self.searchController.searchResultsUpdater = self

        //UISearchController.searchBar 有設置委任對象-self:ViewController
        self.searchController.searchBar.delegate = self
        
        //UISearchController 有設置委任對象-self:ViewController
        self.searchController.delegate = self
        
        self.searchController.isActive = true
        
        //搜尋時是否隱藏 NavigationBar
        //這個範例沒有使用 NavigationBar 所以設置什麼沒有影響
        self.searchController
            .hidesNavigationBarDuringPresentation = false

        //搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        self.searchController
            .obscuresBackgroundDuringPresentation = false
 
        //搜尋框的樣式
        self.searchController
            .searchBar.searchBarStyle = .prominent

        //設置搜尋框的尺寸為自適應
        //因為會擺在 tableView 的 header,所以尺寸會與 tableView 的 header 一樣
        self.searchController.searchBar.sizeToFit()

        //加載UISearchController時自動顯示keyboard
        self.searchController.definesPresentationContext = true
       
        //將搜尋框擺在 tableView 的 header
        self.tableView.tableHeaderView = self.searchController.searchBar

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        //將搜尋框擺在 tableView 的 header
        self.tableView.tableHeaderView = self.searchController.searchBar

        //加載UISearchController時自動顯示keyboard
        DispatchQueue.main.async {
            self.searchController.isActive = true
            self.searchController.searchBar.becomeFirstResponder()
            }
        
    }

}

