// Copyright 2021 - 2022 321CA Soare Mihai Daniel
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./fs_utils.h"
#include "./struct.h"

#define MAX_INPUT_LINE_SIZE 300

File *create_new_file(Dir *parent, char *name)
{
	File *new_file;

	new_file = malloc(sizeof(*new_file));
	DIE(NULL == new_file, "malloc failed");

	new_file->name = strdup(name);
	new_file->parent = parent;
	new_file->next = NULL;

	return new_file;
}

Dir *create_new_dir(Dir *parent, char *name)
{
	Dir *new_dir;

	new_dir = malloc(sizeof(*new_dir));
	DIE(NULL == new_dir, "malloc failed");

	new_dir->name = strdup(name);
	new_dir->parent = parent;
	new_dir->next = NULL;

	new_dir->head_children_dirs = NULL;
	new_dir->head_children_files = NULL;

	return new_dir;
}

File *remove_file(File *file)
{
	free(file->name);
	free(file);

	return NULL;
}

void get_arguments(char **action, char **name, char **newname, int *nr_arg)
{
	char *arguments = malloc(MAX_INPUT_LINE_SIZE);
	DIE(NULL == arguments, "malloc failed");

	// reads a new line
	fgets(arguments, MAX_INPUT_LINE_SIZE, stdin);

	// parse it into tokens by the delim newline and " "
	const char *delim = "\n ";
	char *token = strtok(arguments, delim);
	while (token) {
		// get the arguments parsed in function of how many they are
		*nr_arg = *nr_arg + 1;

		if (*nr_arg == 1)
			*action = strdup(token);
		else if (*nr_arg == 2)
			*name = strdup(token);
		else if (*nr_arg == 3)
			*newname = strdup(token);

		token = strtok(NULL, delim);
	}

	free(arguments);
}
