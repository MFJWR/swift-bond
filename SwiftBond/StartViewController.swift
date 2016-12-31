import UIKit
import Bond

class StartViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.bnd_text
            .map { (str: String?) -> String? in
                return  "Your input is '\(str!)'!"
            }
            .bind(to: label.bnd_text)
    }
}
