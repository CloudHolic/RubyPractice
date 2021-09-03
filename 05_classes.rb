# frozen_string_literal: true

require 'gserver'

# class LogServer
class LogServer < GServer
  def initialize
    super(12_345)
  end

  def serve(client)
    client.puts get_end_of_log_file
  end

  private

  def get_end_of_log_file
    File.open('D:\Downloads\log.log') do |log|
      log.seek(-500, IO::SEEK_END)
      log.gets
      log.read
    end
  end
end

# server = LogServer.new
# server.start.join

# -----------------------------------------------------------
 
# class Parent
class Parent
  def say_hello
    puts "Hello from #{self}"
  end

  def to_s
    'Parent called'
  end
end

p = Parent.new
p.say_hello

class Child < Parent
end

c = Child.new
c.say_hello

# -----------------------------------------------------------

class Person
  include Comparable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name.to_s
  end

  def <=>(other)
    name <=> other.name
  end
end

p1 = Person.new('Matz')
p2 = Person.new('Guido')
p3 = Person.new('Larry')

puts "#{p1.name}'s name > #{p2.name}'s name" if p1 > p2

puts 'Sorted list:'
puts [p1, p2, p3].sort

# -----------------------------------------------------------

# class VowelFinder
class VowelFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  def each(&block)
    @string.scan(/[aeiou]/, &block)
  end
end

vf = VowelFinder.new('the quick brown fox jumped')
p vf.inject(:+)

# -----------------------------------------------------------

# module Summable
module Summable
  def sum
    inject(:+)
  end
end

class Array
  include Summable
end

class Range
  include Summable
end

class VowelFinder
  include Summable
end

puts [1, 2, 3, 4, 5].sum
puts ('a'..'m').sum

vf2 = VowelFinder.new('the quick brown fox jumped')
puts vf2.sum
