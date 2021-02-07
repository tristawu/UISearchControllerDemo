//
//  ViewControllerExtensions.swift
//  UISearchControllerDemo
//
//  Created by Trista on 2021/2/7.
//

//import Foundation
import UIKit

//委任的對象設置為self ：ViewController 本身，對 ViewController 新增一個擴展(選擇Swift File新增擴展檔案)，在新增的擴展檔案為 ViewController 擴展遵循協定，實作委任對象的方法

//定義擴展用來實作 UITableView 委任的方法
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //UISearchController的屬性isActive，用來表示目前是否為搜尋狀態
        //當搜尋狀態時就是顯示搜尋後的結果searchArr
        if (self.searchController.isActive) {
            return self.searchArr.count
        }
        //非搜尋狀態時則是顯示所有資訊cities
        else {
            return self.cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "Cell", for: indexPath as IndexPath)

        //UISearchController的屬性isActive，用來表示目前是否為搜尋狀態
        //當搜尋狀態時就是顯示搜尋後的結果searchArr
        if (self.searchController.isActive) {
            cell.textLabel?.text =
              self.searchArr[indexPath.row]
            return cell
        }
        //非搜尋狀態時則是顯示所有資訊cities
        else {
            cell.textLabel?.text =
              self.cities[indexPath.row]
            return cell
        }
    }

}

//定義擴展用來實作 UITableView 委任的方法
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(
            at: indexPath as IndexPath, animated: true)
        
        //UISearchController的屬性isActive，用來表示目前是否為搜尋狀態
        //當搜尋狀態時就是顯示搜尋後的結果searchArr
        if (self.searchController.isActive) {
            print("你選擇的是 \(self.searchArr[indexPath.row])")
        }
        //非搜尋狀態時則是顯示所有資訊cities
        else {
            print("你選擇的是 \(self.cities[indexPath.row])")
        }
    }
    
}

//定義擴展用來實作更新搜尋結果的方法
extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    //加載UISearchController時自動顯示keyboard
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
    }
    //加載UISearchController時自動顯示keyboard
    func presentSearchController(_ searchController: UISearchController)
    {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //guard提前退出類似if的用法，但guard後面一定要接一個else，如果條件表達式返回false時，會執行{}內的程式
        //取得搜尋文字
        guard let searchText =
          searchController.searchBar.text else {
            return
        }

        //對原始資料的陣列使用filter()方法篩選資訊，以比對文字的方式來搜尋
        self.searchArr = self.cities.filter(
          { (city) -> Bool in
            
            /*
            //將文字轉成 NSString 型別
            let cityText:NSString = city as NSString

            //比對這筆資訊有沒有包含要搜尋的文字
            return (cityText.range(of: searchText, options:
                NSString.CompareOptions.caseInsensitive).location)
            != NSNotFound
            */
            return city.contains(searchText)
            
        })

    }

}
