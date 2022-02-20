# Godot-Hierarchal-State-Machine
A generic hierarchal finite state machine for Godot 3.x.

## What is a hierarchal state machine?
I suggest looking at this video https://youtu.be/R2_XmRefnsY

## Why use a state machine?
A state machine lets you seperate the behaviour your object into different states, such as splitting a player into a 'walk', 'idle', 'jump' state, etc. 
This prevents determining your objects' behaviour with a long series of `if` statements, and makes it easier to debug unintended behaviour, as you can narrow it down to a single state

## Why use a hierarchal state machine?
The issue with a barebones state machine is that lots of code is reused in similar states. 
Also, the more states there are, the more difficult it becomes to add more states. 
Say you add a 'swimming' state to your player, now there needs to be a state transition to swimming from 'idle', 'walking', 'crouching', 'jumping', etc. And it will just get exponentially out of hand.

Using hierarchy solves these issues by letting states inherit broad behaviours and transitions.
You can cluster 'idle', 'walking', and 'crouching' as 'grounded states'. Then define it so all grounded states experience ground friction, will reset your double jump, etc.
Adding a new state becomes easier as you can just broadly define all grounded states to transition to the new one.

Even better, you can reduce the amount of transitions by creating transitions to the 'broad' parent states. 
Now instead of individually transitioning to 'idle', 'walking', or 'crouching', you can transition only to 'grounded state' which then decides itself which individual state is appropriate.
This also means if you add a new ground state (say rolling), you don't have to add a transition to it in all the relevant states. 
You can just add the rolling transition logic to 'grounded state', which all the relevant states already transition to.

To summarise, a hierarchal state machine separates your logic to make is easy to understand and debug; significantly reduces the amount of code required; and most importantly makes it far easier to add new behaviour to a complex object.

## Project explanation
The state machine is designed to have as few features as possible while still being extremely powerful. See the example project to aid you in your understanding.
The three main components of the project are:
- The machine itself
- The state tree
- The state condition library

### The machine itself
The state machine is intended to be added as the child of any generic node that wants to interface it. The machine will initialise itself when you set its 'Target' variable to the node you want it to control.
Typically you want the machine to update every frame, so you will call its update function from target's _physics_process() or _process() function. Updating the machine will execute the current state's behaviour and then check if a state transition should occur.

The machine *must* have a child called "RootState" that inherits the `State` class, and a child called "TransitConditions" that inherits the `TransitConditions` class. Of course you can change this.

### The state tree
The state hierarchy is organised into a tree using godot's built-in node system. All states are children of the RootState, do not put anything that isn't a state in this tree.
A state inherits behaviour up the tree by 'extending' the script of its parent (see the example). This means the state will inherit all of its parent's functions, constants, state transitions, etc.

As you should understand from the YouTube video, only the lower-level states with no children are considered actual states that can execute (I call these the leaf states). 
Non-leaf states must override the _choose_substate() function, otherwise the machine won't be able to transition down to a real state from there.

![Alt text](https://cdn.discordapp.com/attachments/477074702662369280/944246317616627774/infographic.png "Title")

All the important functions that you want to be inheriting between states are found in the `State` class, and prefixed with and underscore. 

A quick recap of how a child can inherit its parent's function in Godot (assuming you are extending the parent):
```swift
# Completely inherit function
# Do nothing, this is automatic
```
```swift
# Do not inherit function
func _function_name():
  pass
```
```swift
# Inherit a function and add functionality on top of it
func _function_name():
  ._function_name() # This calls the parent's version of the function
  # Add functionality here
```
  
  ### The state condition library
  The transitions between states are stored as `StateTransition` objects. This makes them easier to inherit and manage.
  Each transition has a reference to a function that returns true/false if the transition is successful, making the conditions easy to reuse/modify across the project.
  You can create a function reference from any function, but I find it most convenient to have a single node/script (the library) contain all these functions in one place.
  See the example project to understand how the `StateTransition` object works, and how to create one.
  
  ### Misc features
  - The `StateMachine` class defines lots of useful signals, I recommend looking at where they are emitted from.
  - The state machine records a history of states with a configurable size. You can pop the most previous state to travel back to it.
  - The `State` class has a few extra helpful functions like _blacklist_transitions(), _on_activate(). These are documented within the class.
