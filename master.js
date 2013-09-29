(function() {
  var CommandStack;

  CommandStack = function() {
    var index, stack;
    stack = [];
    index = 0;
    return {
      execute: function(command) {
        stack[index] = command;
        command.execute();
        return stack.length = index += 1;
      },
      undo: function() {
        var command;
        if (this.canUndo()) {
          index -= 1;
          command = stack[index];
          command.undo();
          return command;
        }
      },
      redo: function() {
        var command;
        if (this.canRedo()) {
          command = stack[index];
          command.execute();
          index += 1;
          return command;
        }
      },
      current: function() {
        return stack[index - 1];
      },
      canUndo: function() {
        return index > 0;
      },
      canRedo: function() {
        return stack[index] != null;
      }
    };
  };

  module.exports = CommandStack;

}).call(this);
