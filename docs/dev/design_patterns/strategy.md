### Procとブロック
```ruby {cmd=true}
hello = lambda do
  puts('Hello')
  puts('I am inside a proc')
end
hello.call
```

```ruby {cmd=true}
name = 'John'
proc = Proc.new do
  name = 'Mary'
end

puts(name)
proc.call
puts(name)
```

```ruby {cmd=true}
return_24 = lambda {24}
puts(return_24.call)
```

```ruby {cmd=true}
multiply = lambda {|x, y| x * y}
n = multiply.call(20, 3)
puts(n)
n = multiply.call(10, 50)
puts(n)
```

```ruby {cmd=true}
def run_it
  puts("Before the yield")
  yield
  puts("After the yield")
end

run_it do
  puts('Hello')
  puts('Comming to you from inside the block')
end
```

```ruby {cmd=true}
def run_it_with_parameter
  puts('Before the yield')
  yield(24)
  puts('After the yield')
end

run_it_with_parameter do |x|
  puts('Hello from inside the proc')
  puts("The value of x is #{x}")
end
```

```ruby {cmd=true}
def run_it_with_parameter(&block)
  puts('Before the call')
  block.call(24)
  puts('After the call')
end

my_proc = lambda {|x| puts("The value of x is #{x}")}
run_it_with_parameter(&my_proc)
```
