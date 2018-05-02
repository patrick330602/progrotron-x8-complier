create:
	bison -d progparser.y
	flex progparser.l
	g++ progparser.tab.c lex.yy.c -o progparser.ex

clean:
	rm -rf *.tab.c *.tab.h lex.yy.c progparser.ex
