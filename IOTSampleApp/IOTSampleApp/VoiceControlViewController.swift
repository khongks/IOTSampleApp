//
//  VoiceControlViewController.swift
//  IOTSampleApp
//
//  Created by khongks on 10/6/17.
//  Copyright © 2017 spocktech. All rights reserved.
//

import UIKit
import MQTTClient

import SpeechToTextV1
import TextToSpeechV1
import AVFoundation

class VoiceControlViewController: UIViewController {
  
  let iotfSession = MQTTSessionManager()
  
  var speechToText: SpeechToText!
  var textToSpeech: TextToSpeech!
  
  @IBOutlet weak var label: UILabel!
  
  enum VoiceControlMsgType: String {
    case BEEP_MSG = "1" //play beep
    case DOCK_MSG = "2" //dock
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    speechToText = SpeechToText(username: Credentials.speechToTextUsername,
                                password: Credentials.speechToTextPassword)
    textToSpeech = TextToSpeech(username: Credentials.textToSpeechUsername,
                                password: Credentials.textToSpeechPassword)
    
    connect()
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func beepPressed(_ sender: Any) {
    send(VoiceControlMsgType.BEEP_MSG.rawValue)
  }
  
  @IBAction func dockPressed(_ sender: Any) {
    send(VoiceControlMsgType.DOCK_MSG.rawValue)
  }
  
  @IBAction func micTouchedDown(_ sender: Any) {
    NSLog("mic button pressed down - starting to listen")
    var settings = RecognitionSettings(contentType: .opus)
    settings.continuous = false
    settings.interimResults = false
    
    let failureSTT = { (error: Error) in print (error) }
    
    self.speechToText.recognizeMicrophone(
      settings: settings,
      failure: failureSTT) {
        results in
        print(results.bestTranscript)
        self.label.text = results.bestTranscript
    }
    NSLog("end STT")
  }
  
  @IBAction func micTouchedUp(_ sender: Any) {
    NSLog("stopping Mic")
    self.speechToText.stopRecognizeMicrophone()
    
    if (self.label.text!.contains("weather")){
      NSLog("found weather")
      
      //fetch weather data from Weather Company Data
      let weather = WeatherData()
      weather.getCurrentWeather()
      
      // print the weather forecast
      print(weather.getGolf())
      
      sleep(1)
      print(weather.getGolf())
      
      let textToSay = weather.getGolf()
      
      let failureTTS = { (error: Error) in print(error) }
      textToSpeech.synthesize(textToSay, voice: SynthesisVoice.us_Michael.rawValue, failure: failureTTS) { data in
        var audioPlayer: AVAudioPlayer // see note below
        audioPlayer = try! AVAudioPlayer(data: data)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        //sleep(4)
        NSLog("end of tts")
      }
    }
  }
  
  func connect() {
    let host = Credentials.ORG_ID + "." + Credentials.IOT_BASE
    let clientId = "a:" + Credentials.ORG_ID + ":" + Credentials.IOT_API_KEY

    if (iotfSession.state != .connected) {
      iotfSession.connect(
        to: host,
        port: 1883,
        tls: false,
        keepalive: 30,
        clean: true,
        auth: true,
        user: Credentials.IOT_API_KEY,
        pass: Credentials.IOT_AUTH_TOKEN,
        will: false,
        willTopic: nil,
        willMsg: nil,
        willQos: MQTTQosLevel.atMostOnce,
        willRetainFlag: false,
        withClientId: clientId)
    }
  }
  
  func send(_ message: String) {
    let CMD_TOPIC = "iot-2/type/" + Credentials.DEV_TYPE + "/id/" + Credentials.DEV_ID + "/cmd/cmdapp/fmt/json"
    NSLog(CMD_TOPIC)
    iotfSession.send(message.data(
      using: String.Encoding.utf8,
      allowLossyConversion: false),
                     topic: CMD_TOPIC,
                     qos:.exactlyOnce,
                     retain: false)
  }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
