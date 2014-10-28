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

```swift
	var notifyView:SFSwiftNotification?
```

In ```viewDidLoad()```

```swift
    notifyView = SFSwiftNotification(frame: notifyFrame,
                                         title: nil,
                                 animationType: AnimationType.AnimationTypeCollision,
                                     direction: Direction.LeftToRight,
                                      delegate: self)
    notifyView!.backgroundColor = UIColor.orangeColor()
    notifyView!.label.textColor = UIColor.whiteColor()
    notifyView!.label.text = "This is an SFSwiftNotification"
    self.view.addSubview(notifyView)
```

To start the notification:

```swift
    @IBAction func notify(sender : AnyObject) {
        
        self.notifyView!.animate(notifyFrame, delay: 1)
    }
```

Settings
--------------------

AnimationTypes:

```swift
    .AnimationTypeCollision
    .AnimationTypeBounce
```

Directions:

```swift
    .TopToBottom
    .LeftToRight
    .RightToLeft
```

Screen
--------------------

![Demo DEFAULT](https://raw.github.com/sferrini/SFSwiftNotification/master/Gif/SFSwiftNotificationBlue.gif)

![Demo DEFAULT](https://raw.github.com/sferrini/SFSwiftNotification/master/Gif/SFSwiftNotification.gif)

![Demo DEFAULT](https://raw.github.com/oduwa/SFSwiftNotification/master/Gif/SFSwiftNotificationTap.gif)
