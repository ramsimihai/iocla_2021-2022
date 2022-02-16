// Copyright 2021 - 2022 321CA Soare Mihai Daniel
#ifndef FS_UTILS_H
#define FS_UTILS_H

#include <errno.h>
#include "./struct.h"

// macro to define if a memory was allocated well and exit if there is an error
#define DIE(assertion, call_description)                                       \
	do {                                                                       \
		if (assertion) {                                                       \
			fprintf(stderr, "(%s, %d): ", __FILE__, __LINE__);                 \
			perror(call_description);                                          \
			exit(errno);                                                       \
		}                                                                      \
	} while (0)

// creates a new file and initialize it with the given name and
// in what directory the file is located
File *create_new_file(Dir *parent, char *name);

// creates a new directory and initialize it with the given name
// and in what directory is located the new directory
Dir *create_new_dir(Dir *parent, char *name);

// frees a file memory
File *remove_file(File *file);

// read a new line and parse the line into arguments needed for the program
// to work such as action, name and newname (it is used for the move operation)
void get_arguments(char **action, char **name, char **newname, int *nr_arg);

#endif
