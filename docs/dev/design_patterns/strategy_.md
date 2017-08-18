Strategy Pattern
---

![](./images/strategy.png )
  
### Procとブロック
  
```ruby
hello = lambda do
  puts('Hello')
  puts('I am inside a proc')
end
hello.call
```
<pre class="language-text">Hello
I am inside a proc
</pre>
  
```ruby
name = 'John'
proc = Proc.new do
  name = 'Mary'
end
puts(name)
proc.call
puts(name)
```
<pre class="language-text">John
Mary
</pre>
  
```ruby
return_24 = lambda {24}
puts(return_24.call)
```
<pre class="language-text">24
</pre>
  
```ruby
multiply = lambda {|x, y| x * y}
n = multiply.call(20, 3)
puts(n)
n = multiply.call(10, 50)
puts(n)
```
<pre class="language-text">60
500
</pre>
  
```ruby
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
<pre class="language-text">Before the yield
Hello
Comming to you from inside the block
After the yield
</pre>
  
```ruby
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
<pre class="language-text">Before the yield
Hello from inside the proc
The value of x is 24
After the yield
</pre>
  
```ruby
def run_it_with_parameter(&block)
  puts('Before the call')
  block.call(24)
  puts('After the call')
end
my_proc = lambda {|x| puts("The value of x is #{x}")}
run_it_with_parameter(&my_proc)
```
<pre class="language-text">Before the call
The value of x is 24
After the call
</pre>
  