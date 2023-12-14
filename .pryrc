# frozen_string_literal: true

# vi: filetype=ruby

Pry::Commands.command /^$/, 'repeat last command on ENTER' do
  _pry_.run_command Pry.history.to_a.last
end

Pry::Commands.block_command "trace", 'Make clean traceback' do
  output = caller.reject! { |line| line['rubies'] || line['gems'] }
  puts "\e[31m#{output.join("\n").gsub(Rails.root.to_s + '/', '')}\e[0m"
end

Pry.config.color = true
Pry.editor = 'vim'

Pry.commands.alias_command 'cont', 'continue'
Pry.commands.alias_command 'exit', 'exit-all'
Pry.commands.alias_command 'code', 'whereami'
