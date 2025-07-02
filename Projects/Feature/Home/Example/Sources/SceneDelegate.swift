import UIKit
import NeedleFoundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var featurehomeComponent: FeatureHomeComponent!
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        registerProviderFactories()
        featurehomeComponent = HomeComponent()
    }
}

