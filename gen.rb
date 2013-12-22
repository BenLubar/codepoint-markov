buf = nil
markov = {}
MaxDepth = 3

ARGF.each_line do |line|
  line.strip!

  if line =~ /^\d+:\d+ /
    if !buf.nil?
      stack = []
      buf.each_codepoint do |c|
        markov[stack] = Hash.new(0) unless markov[stack]
        markov[stack][c] += 1
        stack = stack[0...(MaxDepth - 1)].unshift c
      end
      markov[stack] = Hash.new(0) unless markov[stack]
      markov[stack][-1] += 1
    end
    buf = line[/ ((.|\n)+)\z/, 1].strip
  elsif !buf.nil? and !line.empty?
    buf << " "
    buf << line.strip
  end
end

open('markov.dat', 'wb') do |f|
  Marshal.dump(markov, f)
end
