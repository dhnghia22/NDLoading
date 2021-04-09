//
//  ExampleViewController.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/7/21.
//

import UIKit

class ExampleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let items: [LoadingStyle] = [
        .Style1,
        .Style2,
        .Style3,
        .Style4,
        .Style5,
        .Style6,
        .Style7
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
}

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(describing: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NDLoading.style = items[indexPath.row]
        NDLoading.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            NDLoading.dissmiss()
        }
    }
}

