# frozen_string_literal: true

def words_from_string(string)
  string.downcase.scan(/[\w']+/)
end

def count_frequency(word_list)
  counts = Hash.new(0)
  word_list.each do |word|
    counts[word] += 1
  end
  counts
end

# p words_from_string("But I didn't inhale, he said (emphatically)")
# p count_frequency(%w[sparky the cat sat on the mat])

raw_text = %(The problem breaks down into two parts. First, given some text as a string, return a list of words. That sounds like an array. Then, build a count for each distinct word. That sounds like a use for a hash---we can index it with the word and use the corresponding entry to keep a count.)

word_list = words_from_string(raw_text)
counts = count_frequency(word_list)
sorted = counts.sort_by { |_, count| count }
top_five = sorted.last(5)

top_five.each do |word, count|
  puts "#{word}: #{count}"
end
# puts top_five.map { |word, count| "#{word}: #{count}"}

# -----------------------------------------------------------

sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end
print sum

# -----------------------------------------------------------

def fib_up_to(max)
  i1 = 1
  i2 = 1
  while i1 <= max
    yield i1
    i1, i2 = i2, i1 + i2
  end
end

fib_up_to(1000) { |f| print f, ' ' }

puts

# -----------------------------------------------------------

result = []
'cat'.each_char.with_index { |item, index| result << [item, index] }

enum = 'cat'.enum_for(:each_char)
# enum.to_a

# -----------------------------------------------------------

triangular_numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end

5.times { print triangular_numbers.next, ' ' }
p triangular_numbers.first(5)

# -----------------------------------------------------------

def Integer.all
  Enumerator.new do |yielder, n: 0|
    loop { yielder.yield(n += 1) }
  end.lazy
end

p Integer.all.first(10)

# -----------------------------------------------------------

class ProcExample
  def pass_in_block(&action)
    @stored_proc = action
  end

  def use_proc(parameter)
    @stored_proc.call(parameter)
  end
end

eg = ProcExample.new
eg.pass_in_block { |param| puts "The parameter is #{param}" }
eg.use_proc(99)

# -----------------------------------------------------------

def power_proc_generator
  value = 1
  -> { value += value }
end

power_proc = power_proc_generator

puts power_proc.call
puts power_proc.call
puts power_proc.call

# -----------------------------------------------------------

proc = lambda do |a, *b, &block|
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc2 = -> a, *b, &block do
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc.call(1, 2, 3, 4) { puts 'in block' }
proc2.call(1, 2, 3, 4) { puts 'in block2' }
