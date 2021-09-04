# frozen_string_literal: true

def varargs(arg1, *rest)
  puts "arg1=#{arg1}. rest=#{rest.inspect}"
end

varargs('one')
varargs('one', 'two')
varargs('one', 'two', 'three')

# -----------------------------------------------------------

# class TaxCalculator
class TaxCalculator
  def initialize(name, &block)
    @name, @block = name, block
  end

  def get_tax(amount)
    puts "#{@name} on #{amount} = #{@block.call(amount)}"
  end
end

tc = TaxCalculator.new('Sales tax') { |amt| amt * 0.075 }
tc.get_tax(100)
tc.get_tax(250)

# -----------------------------------------------------------

print '(t)imes or (p)lus: '
operator = gets
print 'number: '
number = Integer(gets)

calc = if operator =~ /^t/
         ->(n) { n * number }
       else
         ->(n) { n + number }
       end
puts((1..10).collect(&calc).join(', '))
