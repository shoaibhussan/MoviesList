//
//  ViewController.swift
//  YoutubeKit
//
//  Created by Ryo Ishikawa on 12/30/2017.
//  Copyright (c) 2017 Ryo Ishikawa. All rights reserved.
//

import UIKit
import YoutubeKit

final class PlayerViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //************************************************//
    // MARK:- Creating properties
    //************************************************//
    
    private var player: YTSwiftyPlayer!
    private let youtubeAPI = YoutubeAPI.shared
    var currentPlayyingId = ""
    var tableData = [MovieVideoViewModel]()
    var currentPlayingIndex = 0
    var isRepeatingEnabled = false

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var pContainerView: UIView!
    @IBOutlet weak var pTimerLabel: UILabel!
    @IBOutlet weak var pDuratioinLabel: UILabel!
    @IBOutlet weak var pIconView: UIImageView!
    @IBOutlet weak var pTableView: UITableView!
    @IBOutlet weak var pSlider: UISlider!
    @IBOutlet weak var pHeightConst: NSLayoutConstraint!

    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        pSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        self.playFileUpdated()
        self.pTableView.register(UINib(nibName: "VideoTableCell", bundle: nil), forCellReuseIdentifier: "VideoTableCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    //************************************************//
    // MARK:- Custom methods, Actions and selectors.
    //************************************************//
    
    @objc func orientationChanged() {
        self.updateFrameOfPlayer(updateOrientation: false)
    }
    
    //************************************************//

    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                // handle drag began
                print("began called")
            case .moved:
                // handle drag moved
                print("moved called")
            case .ended:
                // handle drag ended
                print("ended called")
                self.player.seek(to: Int(slider.value), allowSeekAhead: false)
            default:
                break
            }
        }
    }

    //************************************************//

    @IBAction func playPausePressed(_ sender: Any) {
        if player.playerState == .playing
        {
            player.pauseVideo()
        }
        else{
            player.playVideo()
        }
    }
    
    //************************************************//

    @IBAction func underConstructionPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            if currentPlayingIndex > 0 {
                currentPlayingIndex -= 1
                self.playFileUpdated()
                return
            }
            if currentPlayingIndex == -1 && isRepeatingEnabled == false{
                self.showErrorAlertWithError(errorMessage: "No more videoo to play")
                currentPlayingIndex = 0
                return
            }
            else if currentPlayingIndex == -1 && isRepeatingEnabled == true{
                self.currentPlayingIndex = tableData.count - 1
                self.playFileUpdated()
            }
            else if currentPlayingIndex == 0 && isRepeatingEnabled == false
            {
                self.showErrorAlertWithError(errorMessage: "No more video to play")
                return
            }
            else if currentPlayingIndex == 0 && isRepeatingEnabled == true
            {
                currentPlayingIndex = tableData.count - 1
                self.playFileUpdated()
            }
        }
        else if sender.tag == 2 {
            if currentPlayingIndex < tableData.count - 1 {
                currentPlayingIndex += 1
                self.playFileUpdated()
            }
            else if currentPlayingIndex == tableData.count - 1 && isRepeatingEnabled{
                currentPlayingIndex = 0
                self.playFileUpdated()
            }
            else{
                self.showErrorAlertWithError(errorMessage: "No more videoo to play")
            }
            
        }
        else if sender.tag == 3 {
            isRepeatingEnabled = !isRepeatingEnabled
            self.showErrorAlertWithError(errorMessage: isRepeatingEnabled ? "Video Repeatetion is ON" : "Video Repeatetion is turned OFF")
        }
        else if sender.tag == 4 {
            currentPlayingIndex = 0
            tableData = tableData.shuffled()
            self.playFileUpdated()
            self.showErrorAlertWithError(errorMessage: "All videdos are shuffled")
        }
    }

    //************************************************//

    func playFileUpdated(){
    
        if !(currentPlayingIndex < tableData.count) {
            return
        }
        if player != nil
        {
            player.pauseVideo()
            pSlider.value = 0
            pTimerLabel.text = "00:00"
            pDuratioinLabel.text = "00:00"
        }
        
        currentPlayyingId = tableData[currentPlayingIndex].key!

        player = YTSwiftyPlayer(
            frame: pContainerView.frame,
            playerVars: [
                .playsInline(true),
                .videoID(currentPlayyingId),
                .showRelatedVideo(false),
                .autoplay(true),
                .showFullScreenButton(false),
                .progressBarColor(.red),
                .showControls(.hidden)
            ])
        player.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:300)
        pContainerView.addSubview(player)
        player.delegate = self
       let playerPath = Bundle(for: PlayerViewController.self).path(forResource: "player", ofType: "html")!
        let htmlString = try! String(contentsOfFile: playerPath, encoding: .utf8)
        player.loadPlayerHTML(htmlString)
        
        self.player.loadVideo(videoID: currentPlayyingId)

    }
    
    //************************************************//

    @IBAction func fullScreenPressed(_ sender: Any) {
        self.updateFrameOfPlayer(updateOrientation: true)
    }
    
    //************************************************//

    func updateFrameOfPlayer(updateOrientation:Bool){
        
        let orientation =  UIDevice.current.orientation

        if orientation == .unknown {
            return
        }
        if updateOrientation {
            if orientation == .portrait {
                let value = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                pHeightConst.constant = UIScreen.main.bounds.size.height
                self.animateChanges()
                
            }
            else if orientation == .landscapeRight || orientation == .landscapeLeft {
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                pHeightConst.constant = 227
                self.animateChanges()
            }
        }
        else
        {
            if orientation == .portrait {
                pHeightConst.constant = 227
                self.animateChanges()
            }
            else if orientation == .landscapeRight || orientation == .landscapeLeft {
                pHeightConst.constant = UIScreen.main.bounds.size.height
                self.animateChanges()
            }
        }
      
    }
    
    //************************************************//

    func animateChanges(){
        UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion: {res in
                self.player.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:self.pContainerView.frame.size.height)
        })
    }

    //************************************************//

    private func fetchVideoList() {
        let request = VideoListRequest(part: [.id, .snippet, .contentDetails], filter: .chart)

        // Please make sure to set your key in `AppDelegate`.
        youtubeAPI.send(request) { result in
            switch result {
            case .success(let response):
                print("YoutubeAPI success: \(response)")
            case .failure(let error):
                print("YoutubeAPI failure: \(error)")
            }
        }
    }
    
    //************************************************//
    // MARK:- UITableview delegate and datasource
    //************************************************//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //************************************************//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryCell : VideoTableCell = self.pTableView.dequeueReusableCell(withIdentifier: "VideoTableCell", for: indexPath) as! VideoTableCell
        countryCell.pResultLabel.text = tableData[indexPath.row].name
        return countryCell
    }
    
    //************************************************//
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        currentPlayingIndex = indexPath.row
        self.playFileUpdated()
    }
    
    //************************************************//

}

//************************************************//
// MARK:- Video player delegate and callbacks.
//************************************************//

extension PlayerViewController: YTSwiftyPlayerDelegate {
    
    //************************************************//

    func playerReady(_ player: YTSwiftyPlayer) {
        print(#function)
        pSlider.isHidden = false
    }
    
    //************************************************//

    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
  
        let duration: TimeInterval = currentTime // 2 minutes, 30 seconds0.
        let (hours, minutes, seconds) = self.secondsToHoursMinutesSeconds(Int(currentTime))
        pTimerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes , seconds)
        let totalDuration: TimeInterval = player.duration! // 2 minutes, 30 seconds
        let (totalhours, totalminutes, totalseconds) = self.secondsToHoursMinutesSeconds(Int(totalDuration))
        let formattedTotalDuration = String(format: "%02d:%02d:%02d", totalhours, totalminutes , totalseconds)
        pDuratioinLabel.text = formattedTotalDuration
        pSlider.value = Float(currentTime)
        pSlider.maximumValue = Float(Double(player.duration ?? 0.0))
    }
    
    //************************************************//

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    //************************************************//

    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        print("\(#function): \(state)")
        
        if player.playerState == .playing
        {
            pIconView.image = UIImage(named: "pIcon")
        }
        else{
            pIconView.image = UIImage(named: "play")
        }
    }

    //************************************************//

    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        print("\(#function): \(playbackRate)")
    }
    
    //************************************************//

    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        print("\(#function): \(error)")
    }
    
    //************************************************//

    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
        print("\(#function): \(quality)")
    }
    
    //************************************************//

    func apiDidChange(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    //************************************************//

    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    //************************************************//

    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    //************************************************//

}

extension Array {
    /// Fisher-Yates shuffle
    mutating func shuffle() {
        for i in stride(from: count - 1, to: 0, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i + 1)))
            (self[i], self[j]) = (self[j], self[i])
        }
    }
}
