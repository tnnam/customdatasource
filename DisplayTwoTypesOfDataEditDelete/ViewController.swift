//
//  ViewController.swift
//  DisplayTwoTypesOfDataEditDelete
//
//  Created by Tran Ngoc Nam on 3/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet var noDataView: UIView!
    
    var hasNoData: Bool = false {
        didSet {
            tableView.tableFooterView = hasNoData ? noDataView : footerView
        }
    }
    
    @IBOutlet weak var switchButtom: UISwitch!
    
    var dataNumber = DataSourceNumber()
    var dataString = DataSourceString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = dataNumber
        
        dataNumber.viewController = self
        dataString.viewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchButtomAction(_ sender: UISwitch) {
        tableView.dataSource = sender.isOn ? dataNumber : dataString
        hasNoData = sender.isOn ? (dataNumber.numbers.count == 0) : (dataString.strings.count == 0)
        tableView.reloadData()
    }
    
    // MARK: Edit And Add
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        guard let receiveData = (unwindSegue.source as? DetailViewController)?.data else { return }
        if let indexPathCurrent = tableView.indexPathForSelectedRow {
            if switchButtom.isOn == true {
                dataNumber.numbers[indexPathCurrent.row] = Int(receiveData)!
            }else {
                dataString.strings[indexPathCurrent.row] = receiveData
            }
            tableView.reloadRows(at: [indexPathCurrent], with: .none)
        } else {
            let row = switchButtom.isOn ? dataNumber.numbers.count : dataString.strings.count
            let newIndexPath = IndexPath(row: row, section: 0)
            if switchButtom.isOn == true {
                dataNumber.numbers.append(Int(receiveData) ?? 0)
            }else {
                dataString.strings.append(receiveData)
            }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        hasNoData = switchButtom.isOn ? (dataNumber.numbers.count == 0) : (dataString.strings.count == 0)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "edit":
            let vc = segue.destination as? DetailViewController
            guard let indexPathSelected = tableView.indexPathForSelectedRow else { return }
            vc?.data = switchButtom.isOn ? "\(dataNumber.numbers[indexPathSelected.row])" : dataString.strings[indexPathSelected.row]
        default:
            print("done")
        }
    }
}

