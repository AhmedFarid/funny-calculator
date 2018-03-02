import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outButLable: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValueStr = ""
    var rightValueStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let error as  NSError {
            print(error.debugDescription)
            
        }
        
        outButLable.text = ""
    }
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outButLable.text = runningNumber
        
        
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        processOperatation(operation: .Divide)
        outButLable.text = ""
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        playSound()
        processOperatation(operation: .Multiply)
        outButLable.text = ""
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        playSound()
        processOperatation(operation: .Subtract)
        outButLable.text = ""
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        processOperatation(operation: .Add)
        outButLable.text = ""
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        playSound()
        processOperatation(operation: currentOperation)
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    
    func processOperatation(operation: Operation) {
        
        if currentOperation != Operation.Empty {
            //A user selected an operater
            if runningNumber != "" {
                rightValueStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                }
                leftValueStr = result
                outButLable.text = result
            }
            
            currentOperation = operation
        }else {
            //this the first 
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

