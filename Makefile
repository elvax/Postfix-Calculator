CC=gcc
MATH=-lm

all: main

gram.tab.c gram.tab.h:	gram.y
	bison -d $<

lex.yy.c: lexer.lex
	flex $<

main: lex.yy.c gram.tab.c
	$(CC) $(FLAGS) -o $@ $^ $(MATH)

clean:
	rm main gram.tab.c lex.yy.c gram.tab.h


# $@ to nazwa bieżącej reguły
# $^ to lista wszystkich bieżących zależności
# $? to lista nieaktualnych plików zależności
# $< to pierwszy plik z listy zależności