SFSwiftNotification
=============


Simple custom user notifications


Install
--------------------

* Manually:
Copy the file ```SFSwiftNotification.swift``` to your project.


* CocoaPods: (Soon available)



Usage
--------------------


In your ViewController

``` 
	var notifyView:SFSwiftNotification?
```

In ```viewDidLoad()```

``` 
    notifyView = SFSwiftNotification(frame: frame,
                                     title: nil,
                                 direction: Direction.LeftToRight,
                                  delegate: self)
    notifyView!.backgroundColor = UIColor.orangeColor()
    notifyView!.label.textColor = UIColor.whiteColor()
    notifyView!.label.text = "This is an SFSwiftNotification"
    self.view.addSubview(notifyView)
```

To start the notification:

```
    @IBAction func notify(sender : AnyObject) {
        
        self.notifyView!.animate(newFrame, delay: 1)
    }
```

Screen
--------------------

![Demo DEFAULT](https://raw.github.com/sferrini/SFSwiftNotification/master/Gif/SFSwiftNotification.gif)
