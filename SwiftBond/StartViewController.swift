import UIKit
import Bond

class StartViewController: UIViewController {
    
    private var stopWatch: StopWatchViewModel?
    
    @IBOutlet weak private var label: UILabel!
    
    @IBOutlet weak private var mainButton: UIButton!
    @IBOutlet weak private var clearButton: UIButton!
    
    private let stopWatchViewModel = StopWatchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainButton.bnd_tap.observe { _ in
            self.stopWatchViewModel.mainAction.value.do()
        }.disposeIn(bnd_bag)
        
        clearButton.bnd_tap.observe { _ in
            self.stopWatchViewModel.clearAction.value.do()
        }.disposeIn(bnd_bag)
        
        stopWatchViewModel.mainAction.observeNext { (action: StopWatchViewModel.Action) -> Void in
            self.mainButton.setTitle(action.description, for: .normal)
        }.disposeIn(bnd_bag)
        
        stopWatchViewModel.clearAction.observeNext { (action: StopWatchViewModel.Action) -> Void in
            self.clearButton.setTitle(action.description, for: .normal)
            self.clearButton.isEnabled = action.enabled
        }.disposeIn(bnd_bag)
        
        stopWatchViewModel.time.bind(to: label)
    }
}
