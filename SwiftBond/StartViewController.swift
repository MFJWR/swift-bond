import UIKit
import Bond

class StartViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.bnd_text
            .bind(to: label.bnd_text)
    }
}
