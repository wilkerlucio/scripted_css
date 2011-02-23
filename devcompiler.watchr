def compile_scripts
  print `clear`
  puts "Compiling at #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
  puts `cake dev:compile`
end

compile_scripts
watch("(.*)+.coffee") { |m| compile_scripts }

@interrupted = false

# Ctrl-C
Signal.trap "INT" do
  if @interrupted
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5

    compile_scripts
    @interrupted = false
  end
end
