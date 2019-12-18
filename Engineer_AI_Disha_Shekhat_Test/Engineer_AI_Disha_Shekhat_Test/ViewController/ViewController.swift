//
//  ViewController.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import UIKit

final class ViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableViewListData: UITableView!
    
    // MARK: - Variable
    private var arrayOfHits: [Hits] = []
    private var currentPageNumber: Int = 0
    private var totalPage : Int = 0
    private var isLoadMore: Bool = false
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    
    // MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    // MARK: - setTableHeader
    private func setTableHeader() {
        let selectedValue = self.arrayOfHits.filter({ $0.isSelected == true })
        if selectedValue.count == 1 {
            self.title = "Number of post: 1"
        } else {
            self.title = "Number of post: \(selectedValue.count)"
        }
    }
    
    // MARK: - RefreshControl Method
    @objc func handleRefresh() {
        self.currentPageNumber = 0
        self.CallListAPI()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - PrepareView
    private func prepareView() {
        
        //setUpTable
        self.tableViewListData.addSubview(self.refreshControl)
        self.tableViewListData.tableFooterView = UIView()
        self.tableViewListData.rowHeight = UITableView.automaticDimension
        
        // cell Register
        self.tableViewListData.register(UINib(nibName: String(describing: ListTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableCell.self))
        
        // ApiCall
        CallListAPI()
    }

    // MARK: - Webservice Call
    private func CallListAPI() {
        self.showProgressHUD()
        APIManager.shared.sendRequest(request: .getListData(self.currentPageNumber), complition: { [weak self] (status, responseData, message) in
            
            guard let `self` = self else {
                return
            }
            
            if status {
                do {
                    let apiResponse = try JSONDecoder().decode(ListModel.self, from: responseData)
                    if let hits = apiResponse.hits {
                        if self.currentPageNumber == 0 {
                            self.arrayOfHits.removeAll()
                        }
                        self.arrayOfHits.append(contentsOf: hits)
                        self.totalPage = apiResponse.totalPage ?? 0
                        self.setTableHeader()
                        self.tableViewListData.reloadData()

                        if self.currentPageNumber == (self.totalPage - 1) {
                            self.isLoadMore = false
                        } else {
                            self.isLoadMore = true
                        }

                    }
                } catch {
                    print("Error in Getting Response \(error.localizedDescription)")
                }
            }
            self.hideProgressHUD()
        })
        
    }

}
// MARK: - Extension TableView Delegate And DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableCell.self), for: indexPath) as! ListTableCell
        cell.hit = self.arrayOfHits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.arrayOfHits.count - 1) && (self.isLoadMore) {
            self.currentPageNumber += 1
            if self.currentPageNumber < self.totalPage {
                CallListAPI()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.arrayOfHits[indexPath.row].isSelected = !self.arrayOfHits[indexPath.row].isSelected
        self.tableViewListData.reloadRows(at: [indexPath], with: .none)
        self.setTableHeader()
    }
}
