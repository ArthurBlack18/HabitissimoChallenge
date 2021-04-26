//
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
   let backgroundImageView = UIImageView()

   var estimationArray = [Estimation]()
   
    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "habitDB")
    }()
    
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
            if let error = error {
                print("Unable to Add Persistent Store")
                print("\(error), \(error.localizedDescription)")

            } else {
                self?.fetchEstimations()
            }
        }
    
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    
        tableView.tableHeaderView?.backgroundColor = color1
        
        tableView.register(UINib(nibName: "EstimationCell", bundle: nil), forCellReuseIdentifier: "EstimationCell")
           
        LocationRequest().getLocations { (location) in
               LOCATION_CONSTANT = location
           }
               
        self.addNavBarImage()


        let img = UIImage(named: "add-off")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(addTapped))
          
    }
         
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        self.tableView.reloadData()

    }
    
    func addNavBarImage() {

        let navController = navigationController!

        let image = UIImage(named: "Logo_Habitissimo.png")
        let imageView = UIImageView(image: image)

        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height

        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2

        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit

        navigationItem.titleView = imageView
    }
         
    
    
    @objc func addTapped(){
          
        let estimationViewController = EstimationViewController()
        estimationViewController.managedObjectContext = persistentContainer.viewContext
            
        navigationController?.pushViewController(estimationViewController, animated: true)
           
// this loads SwiftUI form - I did for testing but I still prefeer Autolayout.
//               let newView = UIHostingController(rootView: SwiftUIView())
//               navigationController?.pushViewController(newView, animated: true)
    }
         
    
    
    //MARK: REQUEST METHODS
    
    func fetchEstimations(){
        print(persistentContainer.viewContext)
        let fetchRequest: NSFetchRequest<Estimation> = Estimation.fetchRequest()

        // Perform Fetch Request
        persistentContainer.viewContext.perform {
            do {
                // Execute Fetch Request
                let result = try fetchRequest.execute()

                // Update
                self.estimationArray = result
                self.tableView.reloadData()

            } catch {
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
        
    }
    
    
         
         //MARK - TableView delegate methods
         
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 30)
        myLabel.font = fontBold(17)
        myLabel.textColor = color1
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.backgroundColor = color3
        headerView.addSubview(myLabel)

        return headerView
    }
     
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Estos son los presupuestos que has solicitado:"
        }

         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return estimationArray.count
         }

//         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//             return 140
//         }

         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

             let myCell = tableView.dequeueReusableCell(withIdentifier: "EstimationCell", for: indexPath) as! EstimationCell
            
            myCell.labelName.text = estimationArray[indexPath.row].name! + " - "
            myCell.labelSubcategory.text = estimationArray[indexPath.row].category
            myCell.labelPhone.text = "Teléfono: " + estimationArray[indexPath.row].phone! + " - "
            myCell.labelLocation.text = estimationArray[indexPath.row].location
            myCell.labelEmail.text = "Email: " + estimationArray[indexPath.row].mail!
            myCell.labelDescription.text = estimationArray[indexPath.row].descript
            
             return myCell
         }
    
    

 }
