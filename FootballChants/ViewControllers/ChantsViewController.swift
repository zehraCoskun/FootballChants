//
//  ChantsViewController.swift
//  FootballChants
//
//  Created by Zehra Coşkun on 18.07.2023.
//

import UIKit

class ChantsViewController: UIViewController {

    // MARK: UI
    
    private lazy var tableVw : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellID)
        return tv
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    private lazy var audioManagerViewModel = AudioManagerViewModel()
    
    // MARK: Lifecycle
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
    }
    
   
}
private extension ChantsViewController {
    func setup(){
        navigationController?.navigationBar.topItem?.title = "Football Chants"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableVw.dataSource = self
        self.view.addSubview(tableVw)
        NSLayoutConstraint.activate([
            tableVw.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableVw.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableVw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableVw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}


// MARK: UITavleViewDataSource

extension ChantsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        let cell = tableVw.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellID, for: indexPath) as! TeamTableViewCell
        cell.configure(with: team, delegate: self)
        return cell
    }
    
    
}
extension ChantsViewController : TeamTableViewCellDelegate {
    func didTapPlayback(for team: Team) {
        audioManagerViewModel.playback(team)
        teamsViewModel.togglePlayback(for: team)
        tableVw.reloadData()
    }
    
    
}
