# frozen_string_literal: true

counts = Hash.new(0)
File.foreach('testfile') do |line|
  line.scan(/\w+/) do |word|
    word = word.downcase
    counts[word] += 1
  end
end
counts.keys.sort.each { |k| print "#{k}:#{counts[k]}" }

words = Fiber.new do
  File.foreach('testfile') do |line|
    line.scan(/\w+/) do |word|
      Fiber.yield word.downcase
    end
  end
  nil
end
counts = Hash.new(0)
while (word = words.resume)
  counts[word] += 1
end
counts.keys.sort.each { |k| print "#{k}:#{counts[k]}" }

# -----------------------------------------------------------

require 'net/http'

pages = %w[www.rubycentral.org slashdot.org www.google.com]

threads1 = pages.map do |page_to_fetch|
  Thread.new(page_to_fetch) do |url|
    http = Net::HTTP.new(url, 80)
    print "Fetching: #{url}\n"
    resp = http.get('/')
    print "Got #{url}: #{resp.message}\n"
  end
end
threads1.each(&:join)

# -----------------------------------------------------------

count = 0
threads2 = 10.times.map do |i|
  Thread.new do
    sleep(rand(0.1))
    Thread.current[:mycount] = count
    count += 1
  end
end
threads2.each do |t|
  t.join
  print t[:mycount], ', '
end
puts "count = #{count}"

# -----------------------------------------------------------

sum = 0
mutex = Mutex.new
threads3 = 10.times.map do
  Thread.new do
    100_000.times do
      mutex.lock
      new_value = sum + 1
      print "#{new_value} " if (new_value % 250_000).zero?
      sum = new_value
      mutex.unlock
    end
  end
end
threads3.each(&:join)
puts "\nsum == #{sum}"
