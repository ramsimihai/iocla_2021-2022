// Copyright 2021 - 2022 321CA Soare Mihai Daniel
#ifndef SIGNATURES_H
#define SIGNATURES_H

// check if there is a file in the current path of the file system
// with a given name
int check_file_existence(File *head_file, char *name);

// check if there is a directory in the current path of the file system
// that has a given name
int check_dir_existence(Dir *head_dir, char *name);

// free recursive all the files from a directory
void __free_file_ierarchy(File *head);

// free recursive all the directories from the system
void __free_file_system(Dir *target);

// iterate through the list of files from a specified directory and
// display them in a tree-like format in function of a level
void show_files(Dir *target, int level);

// verify if move operation can be done to a file or a directory by looking
// at their oldname and newname and respond accordingly the case
int verify_existence(Dir *parent, char *oldname, char *newname);

// create a new file in the current directory with a given name
void touch(Dir* parent, char* name);

// create a new directory in the current directory with a given name
void mkdir(Dir* parent, char* name);

// show all the directories and the files from the current directory
void ls(Dir* parent);

// remove a file with a given from the current directory
void rm(Dir* parent, char* name);

// remove a directory with a given name and its contents from
// the current directory
void rmdir(Dir* parent, char* name);

// iterate through the directories of the file system and move into the
// directory with the given name
void cd(Dir** target, char *name);

// create a string which contains the path from the home directory
// to the current directory
char *pwd(Dir* target);

// stop the program and free the contents of the file system
void stop(Dir* target);

// display recursively in a tree-like format the directories and the files
// from the current directory
void tree(Dir* target, int level);

// rename a file or directory with a new name
void mv(Dir* parent, char *oldname, char *newname);

#endif
