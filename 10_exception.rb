# frozen_string_literal: true

require 'open-uri'

page = 'podcasts'
file_name = "#{page}.html"
web_page = open("http://pragprog.com/#{page}")
output = File.open(file_name, 'w')
begin
  while (line = web_page.gets)
    output.puts line
  end
rescue Exception
  STDERR.puts "Failed to download #{page}: #{$!}"
  output.close
  File.delete(file_name)
  raise
ensure
  output.close
end

# -----------------------------------------------------------

# raise

# raise 'Missing name' if name.nil?

# if i >= names.size
  # raise IndexError, "#{i} >= size (#{names.size}"
# end
# raise ArgumentError, 'Name too big', caller[1..-1]

# -----------------------------------------------------------

class RetryException < RuntimeError
  attr :ok_to_retry
  def initialize(ok_to_retry)
    @ok_to_retry = ok_to_retry
  end
end

def read_data(socket)
  data = socket.read(512)
  if data.nil?
    raise RetryException.new(true), 'transient read error'
  end
end

begin
  stuff = read_data(socket)
  # .. Do something
rescue RetryException => detail
  retry if detail.ok_to_retry
  raise
end

# -----------------------------------------------------------

word_list = File.open('wordlist')
catch(:done) do
  result = []
  while (line = word_list.gets)
    word = line.chomp
    throw :done unless word =~ /^\w+$/
    result << word
  end
  puts result.reverse
end

# -----------------------------------------------------------

def prompt_and_get(prompt)
  print prompt
  res = readline.chomp
  throw :quit_requested if res == '!'
  res
end

catch :quit_requested do
  name = prompt_and_get('Name: ')
  age = prompt_and_get('Age: ')
  sex = prompt_and_get('Sex: ')
  # Do something
end
