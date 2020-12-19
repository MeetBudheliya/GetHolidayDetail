//
//  ViewController.swift
//  GetHolidayDetail
//
//  Created by MAC on 18/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var listofHolidays = [HolidayDetail]()
    {
        didSet{
            DispatchQueue.main.async {
                    self.tblView.reloadData()
                self.navigationItem.title = "\(self.listofHolidays.count) Records Found"
            }
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Enter Valid Country Code"
        tblView.delegate = self
        tblView.dataSource = self
        searchbar.delegate = self
        tblView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let holidays = listofHolidays[indexPath.row]
        cell.lbl1.text = holidays.name
        cell.lbl2.text = holidays.date.iso
        cell.lbl3.text = holidays.description
        return cell
    }

}
extension ViewController:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchbar.text else { return }
        let holidayreuest = HolidayRequest(countryCode: searchText)
        holidayreuest.getHolidays{ [weak self]result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self!.listofHolidays = holidays
                print(self!.listofHolidays.count)
            }
            
        }
    }
}
