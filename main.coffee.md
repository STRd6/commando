Command Stack
-------------

A simple stack based implementation of executable and undoable commands.

    CommandStack = (stack=[]) ->
      index = stack.length

      execute: (command) ->
        stack[index] = command
        command.execute()

        index += 1

        # Be sure to blast obsolete redos
        stack.length = index

        return this

      undo: ->
        if @canUndo()
          index -= 1

          command = stack[index]
          command.undo()

          return command

      redo: ->
        if @canRedo()
          command = stack[index]
          command.execute()

          index += 1

          return command

      current: ->
        stack[index-1]

      canUndo: ->
        index > 0

      canRedo: ->
        stack[index]?

      stack: ->
        stack.slice(0, index)

    module.exports = CommandStack

TODO
----

Integrate Observables
