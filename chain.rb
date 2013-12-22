open('markov.dat', 'rb') do |f|
  $markov = Marshal.load(f)
end

class Hash
  def sample
    n = 0
    each do |k, v|
      n += v
    end

    n = Random.rand(0...n)

    each do |k, v|
      n -= v
      if n < 0
        return k
      end
    end
  end
end

MaxDepth = 3
def chain
  stack = []
  buf = ""

  while true
    c = $markov[stack].sample
    stack = stack[0...(MaxDepth - 1)].unshift c
    if c == -1
      return buf
    end
    buf.concat(c)
  end
end

puts chain
