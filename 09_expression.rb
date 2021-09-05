# frozen_string_literal: true

# class ScoreKeeper
class ScoreKeeper
  def initialize
    @total_score = @count = 0
  end

  def <<(score)
    @total_score += score
    @count += 1
    self
  end

  def average
    raise 'No scores' if @count.zero?

    Float(@total_score) / @count
  end
end

scores = ScoreKeeper.new
scores << 10 << 20 << 40
puts "Average = #{scores.average}"

# -----------------------------------------------------------

# class SomeClass
class SomeClass
  def []=(*params)
    value = params.pop
    puts "Indexed with #{params.join(', ')}"
    puts "value = #{value.inspect}"
  end
end

s = SomeClass.new
s[1] = 2
s['cat', 'dog'] = 'enemies'

# -----------------------------------------------------------

# class ProjectList
class ProjectList
  def initialize
    @projects = []
  end

  def projects=(list)
    @projects = list.map(&:upcase)  # 대문자로 저장
  end

  def [](offset)
    @projects[offset]
  end
end

list = ProjectList.new
list.projects = %w[strip sand prime sand paint sand paint rub paint]
puts list[3]
puts list[4]

# -----------------------------------------------------------

a, b = 1, 2
a, b = b, a

# -----------------------------------------------------------

# class List
class List
  def initialize(*values)
    @list = values
  end

  def +(other)
    @list.push(other)
  end
end

a = List.new(1, 2)
a += 3

# -----------------------------------------------------------

3.times do
  print 'Ho! '
end

0.upto(9) do |x|
  print x, ' '
end

0.step(12, 3) { |x| print x, ' ' }

[1, 1, 2, 3, 5].each { |val| print val, ' '}

# -----------------------------------------------------------

# class Periods
class Periods
  def each
    yield 'Classical'
    yield 'Jazz'
    yield 'rock'
  end
end

periods = Periods.new
periods.each do |genre|
  print genre, ' '
end

# -----------------------------------------------------------

x = 'initial value'
y = 'another value'
[1, 2, 3].each do |x|
  y = x + 1
end
puts [x, y]

a = 'never used' if false
[99].each do |i|
  a = i
end
puts a

square = 'yes'
total = 0
[1, 2, 3].each do |val; square|
  square = val * val
  total += square
end
puts "Total = #{total}, square = #{square}"
