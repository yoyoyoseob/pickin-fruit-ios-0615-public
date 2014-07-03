---
tags: pickerview, delegate, protocol
languages: objc
---

# Pickin' Fruit

One last delegate/protocol to warm up. Let's make a slot machine

## Instructions

  1. A picker View "displays a spinning wheel or slot-machine motif of values". I've already placed one on the storyboard. Your job is to implement it's **2** delegates.
  2. The first one is called `UIPickerViewDataSource`. Check out the docs on it...it should look pretty familiar from `UITableView`. Implement the required methods there to display the number of rows for all of the fruits. Also there should be three components.
  3. Now implement the `UIPickerViewDelegate` to put in the appropriate text in each row. Each component (think column) should have the same stuff in it.
  4. When the spin button is pressed, use the `selectRow:inComponent:animated:` to randomly spin each component to a row.
  5. If they land on the same fruit, display a `UIAlertView` that says whether you won or lost. There should be two button: `Cancel` and `Spin`. These should do reasonable things.
