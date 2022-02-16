CLFAGS  += -Wall
LDFLAGS += -lcrypto

old-hits: old-hits.o
	$(CC) $(CLFAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f old-hits *.o

