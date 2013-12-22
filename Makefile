verse: markov.dat chain.rb
	ruby chain.rb
.PHONY: verse

markov.dat: pg10.txt gen.rb
	ruby gen.rb pg10.txt

pg10.txt:
	rm -f pg10.txt
	wget http://www.gutenberg.org/cache/epub/10/pg10.txt
	sed \
		-e '0,/The Old Testament of the King James Version of the Bible/d' \
		-e '/End of the Project Gutenberg EBook of The King James Bible/,$$d' \
		-e 's/ \([0-9]\+:[0-9]\+\)/\n\n\1/g' \
		-i pg10.txt
