CommandStack = require "../main"

ok = assert
equals = assert.equal

describe "CommandStack", ->
  it "undo on an empty stack returns undefined", ->
    commandStack = CommandStack()
  
    equals commandStack.undo(), undefined
  
  it "redo on an empty stack returns undefined", ->
    commandStack = CommandStack()
  
    equals commandStack.redo(), undefined
  
  it "executes commands", ->
    command =
      execute: ->
        ok true, "command executed"
  
    commandStack = CommandStack()
  
    commandStack.execute command
  
  it "can undo", ->
    command =
      execute: ->
      undo: ->
        ok true, "command executed"
  
    commandStack = CommandStack()
    commandStack.execute command
  
    commandStack.undo()
  
  it "can redo", ->
    command =
      execute: ->
        ok true, "command executed"
      undo: ->
  
    commandStack = CommandStack()
    commandStack.execute command
  
    commandStack.undo()
    commandStack.redo()
  
  it "executes redone command once on redo", ->
    command =
      execute: ->
        ok true, "command executed"
      undo: ->
  
    commandStack = CommandStack()
    commandStack.execute command
  
    commandStack.undo()
    commandStack.redo()
  
    equals commandStack.redo(), undefined
    equals commandStack.redo(), undefined
  
  it "command is returned when undone", ->
    command =
      execute: ->
      undo: ->
  
    commandStack = CommandStack()
    commandStack.execute command
  
    equals commandStack.undo(), command, "Undone command is returned"
  
  it "command is returned when redone", ->
    command =
      execute: ->
      undo: ->
  
    commandStack = CommandStack()
    commandStack.execute command
    commandStack.undo()
  
    equals commandStack.redo(), command, "Redone command is returned"
  
  it "cannot redo an obsolete future", ->
    Command = ->
      execute: ->
      undo: ->
  
    commandStack = CommandStack()
    commandStack.execute Command()
    commandStack.execute Command()
  
    commandStack.undo()
    commandStack.undo()
  
    equals commandStack.canRedo(), true
  
    commandStack.execute Command()
  
    equals commandStack.canRedo(), false
