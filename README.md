SFSwiftNotification
=============

Simple custom user notifications

(**DEPRECATED AND NO LONGER MAINTAINED.**)

Install
--------------------

* Copy the file ```SFSwiftNotification.swift``` into your project.


Usage
--------------------


In your ViewController

```swift
var notificationView: SFSwiftNotification?
```

In ```viewDidLoad()```

```swift
notificationView = SFSwiftNotification(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50),
                                       title: "This is an SFSwiftNotification",
                               animationType: .Collision,
                                   direction: .RightToLeft,
                                    delegate: self)
    
notificationView!.backgroundColor = UIColor.orangeColor()
notificationView!.label.textColor = UIColor.whiteColor()
    
self.view.addSubview(notificationView!)
```

To start the notification:

```swift
@IBAction func notify(sender : AnyObject) {
    
    self.notificationView!.animate(1)
}
```

Settings
--------------------

AnimationTypes:

```swift
.Collision
.Bounce
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
