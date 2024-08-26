//
//  AppDelegate.swift
//  Navigation
//
import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth
import CoreData

enum Constants {
    static let feedTabImage = "text.bubble"
    static let feedTabImageFill = "text.bubble.fill"
    static let profileTabImage = "person.crop.circle"
    static let profileTabImageFill = "person.crop.circle.fill"
    static let likePostTabImage = "heart.circle"
    static let likePostTabImageFill = "heart.circle.fill"
}

@main
 class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        NetworkManager.request(.films)
        
        // create tab bar with feed and profile items
        let loginVC = LoginViewController()
        let loginInspector = MyLoginFactory().makeLoginInspector()
        loginVC.loginDelegate = loginInspector
        
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        let fVC = FeedViewController(viewModel: viewModel)
        
        let likeVC = LikePostViewController()
        

        let feedNC = UINavigationController(rootViewController: fVC)
        feedNC.tabBarItem = UITabBarItem(title: "Feed", //"AppDelegate.feed".localized,
                                         image: UIImage(systemName: Constants.feedTabImage),
                                         selectedImage: UIImage(systemName: Constants.feedTabImageFill ))

        let profileNC = UINavigationController(rootViewController: loginVC)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", //"AppDelegate.profile".localized,
                                            image: UIImage(systemName: Constants.profileTabImage ),
                                            selectedImage: UIImage(systemName: Constants.profileTabImageFill))
        
        let likeNC = UINavigationController(rootViewController: likeVC)
        likeNC.tabBarItem = UITabBarItem(title: "Favorites", //"AppDelegate.profile".localized,
                                            image: UIImage(systemName: Constants.likePostTabImage ),
                                            selectedImage: UIImage(systemName: Constants.likePostTabImageFill))
        
      
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .placeholderText
        tabBarController.viewControllers = [ profileNC, feedNC, likeNC ]
        
        // activate main window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController //FoldersVC() //tabBarController
        window.makeKeyAndVisible()
        self.window = window
        let coordinator = MainCoordinator()
        coordinator.start()
        
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
            }
        }
        
        print(makeKey(key: key))
        print(keyFromUint(array: criptoKey) ?? " ")
        return true
    }
     func applicationWillTerminate(_ application: UIApplication) {
         do{
             try Auth.auth().signOut()
         } catch {
             print(error.localizedDescription)
         }
     }
     
     lazy var persistentContainer: NSPersistentContainer = {
         
         let container = NSPersistentContainer(name: "Navigation")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()
     
}

