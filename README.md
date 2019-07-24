<div style="align: center">
<img src="https://github.com/MaterYi/-InfiteeAnimation/blob/master/Fodder/InfiteeAnimation.png" width="600" height="450"/>
</div>

## InfiteeAnimation,优秀的入门iOS动画Demo

之前无意在App Store看到了一个叫Infintee的app，瞬间被其华丽流畅的交互动画吸引了。所以花了一点时间尝试实现里面的动画效果。
实现过程发现里面的动画还是挺复杂的，所以自己目前还不能100%实现里面的所有动画
希望各路大神有兴趣的可以交流一下。

## 系统需求
- iOS 9.0 +
- Xcode 9.0 +
- Swift 5

## 涉及技术要点
- CAAnimation 

项目主要使用CAAnimation库构建动画,包括其各种子类，CASpringAnimation，CAAnimationGroup,CAKeyframeAnimation。

- 自定义转场动画

自定义Navigation转场动画

- tableviewCell动画

自定义tableviewCell动画

## 展示
 ![image](https://github.com/MaterYi/-InfiteeAnimation/blob/master/Fodder/test.gif)

## 部分代码展示
```
 let positAnimation = CABasicAnimation()
positAnimation.keyPath = "position"
positAnimation.fromValue = closeButton.center
let centerX = self.frame.size.width - 25
let toPoint = CGPoint(x: centerX, y: closeButton.center.y)
positAnimation.toValue = toPoint

positAnimation.fillMode = .forwards
positAnimation.isRemovedOnCompletion = false

let rotationAnimation = CABasicAnimation()
rotationAnimation.keyPath = "transform.rotation.z"
rotationAnimation.fromValue = 0
rotationAnimation.toValue = Double.pi
rotationAnimation.fillMode = .forwards
rotationAnimation.isRemovedOnCompletion = false

let groupAnimation = CAAnimationGroup()
groupAnimation.animations = [positAnimation, rotationAnimation]
groupAnimation.delegate = self
groupAnimation.duration = 0.4
groupAnimation.fillMode = .forwards
groupAnimation.isRemovedOnCompletion = false
groupAnimation.setValue(toPoint, forKey: "posit")
closeButton.layer.add(groupAnimation, forKey: nil)
```

## 运行
`git clone`项目之后直接点击`InfiteeAnimation.xcworkspace`运行

## 后续更新
- 完善Infintee其他动画效果
- 优化动画流畅性