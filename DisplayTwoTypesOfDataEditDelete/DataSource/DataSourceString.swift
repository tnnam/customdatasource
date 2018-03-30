//
//  DataSourceString.swift
//  DisplayTwoTypesOfDataEditDelete
//
//  Created by Tran Ngoc Nam on 3/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class DataSourceString: NSObject, UITableViewDataSource {
    
    var strings = ["Ha Noi", "Ho Chi Minh", "Da Nang"]
    var viewController: ViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = strings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            strings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            viewController?.hasNoData = strings.count == 0
        }
    }
}
