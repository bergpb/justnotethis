load './app.rb'

# dont print object after operation
Pry.config.print = proc { |output, value| output.puts "=> #{value.inspect}" }

# define emacs with default editor
Pry.config.editor = 'emacs'
