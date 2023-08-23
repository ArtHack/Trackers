import UIKit

class AlertPresenter {
    func showAlert(controller: UIViewController?, model: AlertModel) {
        
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .actionSheet)
        
        let action = UIAlertAction(
            title: model.buttonText,
            style: .destructive,
            handler: model.completion)
        
        let cancelAction = UIAlertAction(
            title: model.cancelText,
            style: .cancel,
            handler: model.cancelCompletion)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        controller?.present(alert, animated: true)
    }
}
