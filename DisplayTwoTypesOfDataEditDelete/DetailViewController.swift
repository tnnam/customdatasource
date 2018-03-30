//
//  DetailViewController.swift
//  DisplayTwoTypesOfDataEditDelete
//
//  Created by Tran Ngoc Nam on 3/30/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var dataTextField: UITextField!
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard data != nil else { return }
        dataTextField.text = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newData = dataTextField.text else { return }
        data = newData
    }

}
