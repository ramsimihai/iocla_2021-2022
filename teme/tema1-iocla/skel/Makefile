CFLAGS=-Wall -Wextra

build:
	gcc $(CFLAGS) *.c -g -o tema

pack:
	zip -FSr 321CA_MihaiDaniel_Soare_bijus_system.zip README Makefile *.c *.h

clean:
	rm -f tema

.PHONY: pack clean

checker:
	python3 checker.py