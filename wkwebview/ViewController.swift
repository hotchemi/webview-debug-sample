import UIKit
import WebKit

class ViewController: UIViewController {
    let wkWebView = WKWebView()
    var backButton: UIButton!
    var forwadButton: UIButton!
    var targetUrl = "https://yahoo.co.jp/"

    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.frame = view.frame
        wkWebView.navigationDelegate = self
        wkWebView.allowsBackForwardNavigationGestures = true
        let urlRequest = URLRequest(url:URL(string:targetUrl)!)
        wkWebView.load(urlRequest)
        view.addSubview(wkWebView)
        createWebControlParts()
    }

    private func createWebControlParts() {
        let buttonSize = CGSize(width:40,height:40)
        let offseetUnderBottom:CGFloat = 60
        let yPos = (UIScreen.main.bounds.height - offseetUnderBottom)
        let buttonPadding:CGFloat = 10
        let backButtonPos = CGPoint(x:buttonPadding, y:yPos)
        let forwardButtonPos = CGPoint(x:(buttonPadding + buttonSize.width + buttonPadding), y:yPos)

        backButton = UIButton(frame: CGRect(origin: backButtonPos, size: buttonSize))
        forwadButton = UIButton(frame: CGRect(origin:forwardButtonPos, size:buttonSize))

        backButton.setTitle("<", for: .normal)
        backButton.setTitle("< ", for: .highlighted)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.backgroundColor = UIColor.black.cgColor
        backButton.layer.opacity = 0.6
        backButton.layer.cornerRadius = 5.0
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.isHidden = true
        view.addSubview(backButton)

        forwadButton.setTitle(">", for: .normal)
        forwadButton.setTitle(" >", for: .highlighted)
        forwadButton.setTitleColor(.white, for: .normal)
        forwadButton.layer.backgroundColor = UIColor.black.cgColor
        forwadButton.layer.opacity = 0.6
        forwadButton.layer.cornerRadius = 5.0
        forwadButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        forwadButton.isHidden = true
        view.addSubview(forwadButton)
    }

    @objc private func goBack() {
        wkWebView.goBack()
    }

    @objc private func goForward() {
        wkWebView.goForward()
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isHidden = (webView.canGoBack) ? false : true
        forwadButton.isHidden = (webView.canGoForward) ? false : true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // ここに入ってくる
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // ここかも
        print(error)
    }
}
