import UIKit
import Bond

class StartViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intObservable = Observable<Int>(0)
        
        let _ = intObservable.observeNext{ (i: Int) -> Void in
            if i == 3 {
                print("san!")
            } else {
                print(i)
            }
        }
        
        let _ =  intObservable.observeCompleted { _ -> Void in
            print("completed.")
        }
        
        
        intObservable.next(1)
        intObservable.next(2)
        intObservable.next(3)
        intObservable.completed()
    }
}
