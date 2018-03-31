//
//  RecordingViewController.swift
//  NYU-Voice
//
//  Created by Liam Wang on 2017/11/21.
//  Copyright © 2017年 HaiyangWang. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var recordingButton: UIButton!
    
    var recordingSession: AVAudioSession!
    
    var soundRecorder : AVAudioRecorder!
    
    var audioPlayer : AVAudioPlayer!
    
    var audios : [String]! = []
    
    let message = "Recordings"
    
    var numberOfRecords : Int = 0
    
    var names : [String]! = []
    
    func setupRecorder(index: Int) {
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        do {
            try recordingSession.setActive(true)
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
        let recordSettings = [AVFormatIDKey : kAudioFormatAppleLossless, AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, AVEncoderBitRateKey : 320000, AVNumberOfChannelsKey : 2, AVSampleRateKey : 41000 ] as [String : Any]
        do {
            try soundRecorder = AVAudioRecorder(url : getFileURL(index: index), settings : recordSettings)
        } catch {
            print("Error")
        }
        soundRecorder.delegate = self
        soundRecorder.prepareToRecord()
    }
    
    func getFileURL(index: Int) -> URL{
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = documentDirectoryURL[0].appendingPathComponent("\(index).m4a")
        return fileURL
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if soundRecorder == nil {
            setupRecorder(index: numberOfRecords)
            soundRecorder.delegate = self
            soundRecorder.record()
            recordingButton.setTitle("Stop recording", for: .normal)
        } else {
            finishRecording(success: true)
            numberOfRecords += 1
            print("audios_count:\(audios.count)")
            UserDefaults.standard.set(audios, forKey: "myAudios")
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumbers")
            insertNewAudio()
        }
    }
    
    func finishRecording(success: Bool) {
        soundRecorder.stop()
        recordingButton.setTitle("Add", for: .normal)
        soundRecorder = nil
        audios.append(String(numberOfRecords))
        if success {
            print("successfully recorded")
        } else {
            print("Mission failed")
        }
    }
    
    func insertNewAudio() {
        let indexPath = IndexPath.init(row: audios.count - 1, section: 0)
        recordingTableView.beginUpdates()
        recordingTableView.insertRows(at: [indexPath], with: .automatic)
        recordingTableView.endUpdates()
        rename(cel: recordingTableView.cellForRow(at: indexPath)!)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let audio: [String] = UserDefaults.standard.object(forKey: "myAudios") as? [String] {
            audios = audio
        }
        if let number: Int = UserDefaults.standard.object(forKey: "myNumbers") as? Int {
            numberOfRecords = number
        }
        if let name: [String] = UserDefaults.standard.object(forKey: "myNames") as? [String] {
            names = name
        }
        if names.count == audios.count {
            names.append("new recording")
        }
        recordingSession = AVAudioSession.sharedInstance()
        recordingTableView.delegate = self
        recordingTableView.dataSource = self
        recordingTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customRecordingCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    @objc func rename(cel: UITableViewCell) {
        let alertController = UIAlertController(title: "Name", message: "Please input name", preferredStyle: .alert)
        alertController.addTextField{(usernameText) ->Void in
            usernameText.placeholder = "Please input name"
        }
        var tempName = "New Recording"
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let rename = UIAlertAction(title: "name", style: .default, handler: {
            ACTION in
            tempName = (alertController.textFields?.first?.text)!
            if tempName.isEmpty {
                tempName = "New Recording"
            }
            cel.textLabel?.text = tempName
            self.names.remove(at: self.names.count-1)
            self.names.append(tempName)
            self.names.append("New Recording")
            UserDefaults.standard.set(self.names, forKey: "myNames")
        })
        alertController.addAction(cancel)
        alertController.addAction(rename)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = audios[indexPath.row]
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL(index: Int(path)!))
            do {
                try recordingSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch let err{
                print("设置类型失败:\(err.localizedDescription)")
            }
            audioPlayer.play()
        } catch let error{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recordingTableView.beginUpdates()
            audios.remove(at: indexPath.row)
            recordingTableView.deleteRows(at: [indexPath], with: .top)
            recordingTableView.endUpdates()
            names.remove(at: indexPath.row)
            UserDefaults.standard.set(audios, forKey: "myAudios")
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumbers")
            UserDefaults.standard.set(self.names, forKey: "myNames")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var recordingTableView: UITableView!
    
    
}


