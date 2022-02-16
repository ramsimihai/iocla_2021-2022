// Copyright 2021 - 2022 321CA Soare Mihai Daniel
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "./fs_utils.h"
#include "./struct.h"
#include "./signatures.h"

#define HOME "home"
#define MAX_INPUT_LINE_SIZE 300

int main()
{
	int nr_arg = 0;
	Dir *file_system = create_new_dir(NULL, HOME);
	Dir *path = file_system;
	char *name, *action, *newname;

	while (-1) {
		nr_arg = 0;

		// get the arguments possible for the file_system
		get_arguments(&action, &name, &newname, &nr_arg);

		if (strcmp(action, "stop") == 0) {
			stop(file_system);
			free(action);
			return 0;
		} else if (strcmp(action, "touch") == 0) {
			touch(path, name);
		} else if (strcmp(action, "mkdir") == 0) {
			mkdir(path, name);
		} else if (strcmp(action, "ls") == 0) {
			ls(path);
		} else if (strcmp(action, "rm") == 0) {
			rm(path, name);
		} else if (strcmp(action, "rmdir") == 0) {
			rmdir(path, name);
		} else if (strcmp(action, "cd") == 0) {
			cd(&path, name);
		} else if (strcmp(action, "tree") == 0) {
			int level = 0;

			tree(path, level);
		} else if (strcmp(action, "pwd") == 0) {
			pwd(path);
		} else if (strcmp(action, "mv") == 0) {
			mv(path, name, newname);
		}

		// frees the arguments allocated for every action
		if (nr_arg == 1) {
			free(action);
		} else if (nr_arg == 2) {
			free(action);
			free(name);
		} else if (nr_arg == 3) {
			free(action);
			free(name);
			free(newname);
		}
	}

	return 0;
}

void touch(Dir* parent, char* name)
{
	File *head_file = parent->head_children_files;

	// checks if there is no file in the ierarchy and adds one
	if (!head_file) {
		File *new_file = create_new_file(parent, name);
		parent->head_children_files = new_file;
		return;
	}

	// iterates through the file ierarchy and adds a new file at the end
	// of the file ierarchy
	while (head_file) {
		if (strcmp(head_file->name, name) == 0) {
			fprintf(stdout, "File already exists\n");
			return;
		} else if (!head_file->next) {
			File *new_file = create_new_file(parent, name);
			head_file->next = new_file;
			return;
		}

		head_file = head_file->next;
	}
}

void mkdir(Dir* parent, char* name)
{
	// checks if there is a parent directory allocated
	if (!parent)
		return;

	Dir *head_dir = parent->head_children_dirs;

	// adds a new directory on the first position in the ierarchy
	if (!head_dir) {
		Dir *new_dir = create_new_dir(parent, name);
		parent->head_children_dirs = new_dir;
		return;
	}

	// iterates through the list of directories and adds it on the last index
	while (head_dir) {
		if (strcmp(head_dir->name, name) == 0) {
			fprintf(stdout, "Directory already exists\n");
			return;
		} else if (!head_dir->next) {
			Dir *new_dir = create_new_dir(parent, name);
			head_dir->next = new_dir;
			return;
		}

		head_dir = head_dir->next;
	}
}

void ls(Dir* parent)
{
	Dir *head = parent->head_children_dirs;
	File *head_file = parent->head_children_files;

	// iterates through directories ierarchy and print the names
	while (head) {
		fprintf(stdout, "%s\n", head->name);
		head = head->next;
	}

	// iterates through files ierarchy and print the names
	while (head_file) {
		fprintf(stdout, "%s\n", head_file->name);
		head_file = head_file->next;
	}
}

int check_file_existence(File *head_file, char *name)
{
	File *check_file = head_file;
	int ok = 0, cnt = 0;

	// iterates through the list of files and checks if there is a file
	// with a given name in the ierarchy
	while (check_file) {
		ok++;

		if (strcmp(check_file->name, name) != 0)
			cnt++;

		check_file = check_file->next;
	}

	if (ok == cnt) {
		printf("Could not find the file\n");
		return 1;
	}

	return 0;
}

void rm(Dir* parent, char* name)
{
	// checks if there is a file in the ierarchy
	if (!parent->head_children_files) {
		printf("Could not find the file\n");
		return;
	}

	int ok = check_file_existence(parent->head_children_files, name);
	if (ok == 1)
		return;

	// checks if there exists only one file in the ierarchy
	if (!parent->head_children_files->next) {
		// deletes the file
		remove_file(parent->head_children_files);
		parent->head_children_files = NULL;
		return;
	}

	// checks if there exists two files in the ierarchy
	if (strcmp(parent->head_children_files->name, name) == 0) {
		// saves the data from the deleted file
		File *deleted_file = parent->head_children_files;
		parent->head_children_files = parent->head_children_files->next;

		// deletes it accordingly
		remove_file(deleted_file);
		return;
	}

	// iterates through the current path files and deletes the file
	// with the given name
	File *prev_file = parent->head_children_files;
	while (prev_file->next) {
		if (strcmp(prev_file->next->name, name) == 0 ||
			strcmp(prev_file->name, name) == 0) {
			File *deleted_file = prev_file->next;
			prev_file->next = prev_file->next->next;
			remove_file(deleted_file);
			return;
		}

		prev_file = prev_file->next;
	}

	printf("Could not find the file\n");
	return;
}

int check_dir_existence(Dir *head_dir, char *name)
{
	Dir *check_dir = head_dir;
	int ok = 0, cnt = 0;

	// iterates through the list of directories and checks if there is a dir
	// with a given name in the ierarchy
	while (check_dir) {
		ok++;

		if (strcmp(check_dir->name, name) != 0)
			cnt++;

		check_dir = check_dir->next;
	}

	if (ok == cnt) {
		printf("Could not find the dir\n");
		return 1;
	}
	return 0;
}

void rmdir(Dir* parent, char* name)
{
	// checks if there is no dir to be removed or there is no parent directory
	if (!parent->head_children_dirs || !parent) {
		printf("Could not find the dir\n");
		return;
	}

	int ok = check_dir_existence(parent->head_children_dirs, name);
	if (ok == 1)
		return;

	// deletes recursive the first directory from the current path
	if (!parent->head_children_dirs->next) {
		// deletes the contents of the deleted directory
		__free_file_system(parent->head_children_dirs);
		__free_file_ierarchy(parent->head_children_dirs->head_children_files);
		free(parent->head_children_dirs);

		parent->head_children_dirs = NULL;
		return;
	}

	if (strcmp(parent->head_children_dirs->name, name) == 0) {
		// saves the data from the deleted dir
		Dir *deleted_dir = parent->head_children_dirs;

		// deletes the dir from the list
		parent->head_children_dirs = parent->head_children_dirs->next;

		// removes the contents of the deleted directory
		__free_file_system(deleted_dir);
		__free_file_ierarchy(deleted_dir->head_children_files);
		free(deleted_dir->name);
		free(deleted_dir);

		return;
	}


	// iterates through the list of directories and removes it and its content
	Dir *prev_dir = parent->head_children_dirs;
	while (prev_dir->next) {
		if (strcmp(prev_dir->next->name, name) == 0 ||
			strcmp(prev_dir->name, name) == 0) {
			// saves the deleted dir before removing it from the list
			Dir *deleted_dir = prev_dir->next;
			prev_dir->next = prev_dir->next->next;

			// deletes its contents
			__free_file_system(deleted_dir);
			__free_file_ierarchy(deleted_dir->head_children_files);
			free(deleted_dir->name);
			free(deleted_dir);
			return;
		}

		prev_dir = prev_dir->next;
	}

	printf("Could not find the dir\n");
}

void cd(Dir** target, char *name)
{
	// checks if the target where to move the current path exists
	if (!target)
		return;

	// checks if the current path is going back in the ierarchy
	if (strcmp(name, "..") == 0) {
		if (!(*target)->parent)
			return;

		*target = (*target)->parent;
		return;
	} else {
		Dir *child_dir = (*target)->head_children_dirs;

		// iterates through directories list and move the current path
		// to the new directory given
		while (child_dir) {
			if (strcmp(child_dir->name, name) == 0) {
				*target = child_dir;
				return;
			}

			child_dir = child_dir->next;
		}
	}

	printf("No directories found!\n");
}

void __free_file_ierarchy(File *head)
{
	while (head) {
		File *temp = head;
		head = head->next;
		remove_file(temp);
	}
}

void __free_file_system(Dir *target)
{
	if (!target)
		return;

	free(target->name);
	Dir *current_dir = target->head_children_dirs;

	while (current_dir) {
		__free_file_system(current_dir);
		Dir *temp = current_dir;
		__free_file_ierarchy(current_dir->head_children_files);
		current_dir = current_dir->next;
		free(temp);
	}
}

void stop(Dir* target)
{
	__free_file_system(target);
	__free_file_ierarchy(target->head_children_files);
	free(target);
}

char *pwd(Dir* target)
{
	char *new_name, *final_name;
	Dir *parent_dir = target->parent;

	// allocs a new string to start with the current dir of the path
	new_name = malloc(strlen(target->name) + 2);
	DIE(NULL == new_name, "malloc failed");

	// starts building the path from the first directory
	strcpy(new_name, "/");
	strcat(new_name, target->name);

	// iterates through the parents of directories and building the path
	// from the first directory to the home directory
	char *temp_name;
	while (parent_dir) {
		temp_name = malloc(strlen(parent_dir->name) + strlen(new_name) + 2);
		DIE(NULL == new_name, "malloc failed");

		strcpy(temp_name, "/");
		strcat(temp_name, parent_dir->name);
		strcat(temp_name, new_name);

		free(new_name);
		new_name = strdup(temp_name);

		if (parent_dir->parent == NULL)
			final_name = strdup(new_name);

		free(temp_name);

		parent_dir = parent_dir->parent;
	}

	// frees the allocated strings
	if (target->parent != NULL) {
		printf("%s\n", final_name);
		free(final_name);
	} else {
		printf("%s\n", new_name);
	}

	free(new_name);

	return NULL;
}

void show_files(Dir *target, int level)
{
	// checks if the files list from the current dir exists
	if (!target->head_children_files)
		return;

	File *current_file = target->head_children_files;

	// iterates through the list and show files name
	while (current_file) {
		for (int i = 0; i < level; i++)
			printf("    ");

		printf("%s\n", current_file->name);
		current_file = current_file->next;
	}
}

void __tree(Dir *target, int level)
{
	// checks if the directory exists
	if (!target)
		return;

	Dir *current_dir = target->head_children_dirs;

	// iterates through the children directories of the given
	// directory recursively and print their name
	while (current_dir) {
		for (int i = 0; i < level; i++)
			printf("    ");

		printf("%s\n", current_dir->name);

		__tree(current_dir, level + 1);
		show_files(current_dir, level + 1);

		current_dir = current_dir->next;
	}

	if (level == 0)
		show_files(target, level);
}

void tree(Dir* target, int level)
{
	__tree(target, level);
}

int verify_existence(Dir *parent, char *oldname, char *newname)
{
	File *head_file = parent->head_children_files;
	Dir *head_dir = parent->head_children_dirs;
	int no_file = 0, no_dir = 0;
	int exist_file = 0, exist_dir = 0;

	// checks if there is a file in the ierarchy with the oldname or the newname
	while (head_file) {
		if (strcmp((head_file->name), oldname) == 0) {
			no_file = 1;
		} else if (strcmp(head_file->name, newname) == 0) {
			exist_file = 1;
		}

		head_file = head_file->next;
	}

	// checks if there is a directory in the ierarchy with the oldname
	// or the newname
	while (head_dir) {
		if (strcmp(head_dir->name, oldname) == 0) {
			no_dir = 1;
		} else if (strcmp(head_dir->name, newname) == 0) {
			exist_dir = 1;
		}

		head_dir = head_dir->next;
	}

	// combine the conditions of existance of oldnames and newnames
	if (exist_file == 1 || exist_dir == 1) {
		printf("File/Director already exists\n");
		return 0;
	} else if (!no_file && !no_dir) {
		printf("File/Director not found\n");
		return 0;
	}

	return 1;
}

void mv_file(Dir *parent, char *oldname, char *newname)
{
	// checks if there is any file in the current directory
	if (!parent->head_children_files)
		return;

	// renames the one and only file that has the oldname from the ierarchy
	if (!parent->head_children_files->next &&
		strcmp(parent->head_children_files->name, oldname) == 0) {
		free(parent->head_children_files->name);
		parent->head_children_files->name = strdup(newname);
		return;
	}

	// renames the first file that has the oldname in the ierarchy
	if (strcmp(parent->head_children_files->name, oldname) == 0) {
		// saves the data from the deleted file
		File *deleted_file = parent->head_children_files;
		free(deleted_file->name);

		// renames the deleted file & deletes it from the list
		deleted_file->name = strdup(newname);
		parent->head_children_files = parent->head_children_files->next;

		// readds the renamed file to the end of the files list
		File *current_file = parent->head_children_files;
		while (current_file) {
			if (!current_file->next) {
				deleted_file->next = NULL;
				current_file->next = deleted_file;
				return;
			}

			current_file = current_file->next;
		}
	}

	// iterates through the list of files and renames the file that has the given
	// oldname with the newname
	File *file = parent->head_children_files;
	while (file->next) {
		if (strcmp(file->next->name, oldname) == 0 ||
			strcmp(file->name, oldname) == 0) {
				// saves the data of the deleted file and remove it
				// from the list
				File *deleted_file = file->next;
				file->next = file->next->next;

				// rename the deleted file and readds it in the list at the end
				free(deleted_file->name);
				deleted_file->name = strdup(newname);
				File *current_file = parent->head_children_files;
				while (current_file) {
					if (!current_file->next) {
						deleted_file->next = NULL;
						current_file->next = deleted_file;
						return;
					}

					current_file = current_file->next;
				}
			}

		file = file->next;
	}
}

void mv_dir(Dir *parent, char *oldname, char *newname)
{
	// checks if there is any directory in the current directory
	if (!parent->head_children_dirs)
		return;

	// renames the one and only director that has the oldname from the ierarchy
	if (!parent->head_children_dirs->next &&
		strcmp(parent->head_children_dirs->name, oldname) == 0) {
		free(parent->head_children_dirs->name);
		parent->head_children_dirs->name = strdup(newname);
		return;
	}

	// renames the first directory that has the oldname in the ierarchy
	if (strcmp(parent->head_children_dirs->name, oldname) == 0) {
		// saves the data from the deleted dir
		Dir *deleted_dir = parent->head_children_dirs;
		free(deleted_dir->name);

		// renames the deleted file & delets it from the list
		deleted_dir->name = strdup(newname);
		parent->head_children_dirs = parent->head_children_dirs->next;

		// readss the renamed file to the end of the directories list
		Dir *current_dir = parent->head_children_dirs;
		while (current_dir) {
			if (!current_dir->next) {
				deleted_dir->next = NULL;
				current_dir->next = deleted_dir;
				return;
			}
			current_dir = current_dir->next;
		}
	}

	// iterates through the list of directories and renames the dir that
	// has the given oldname with the newname
	Dir *dir = parent->head_children_dirs;
	while (dir->next) {
		if (strcmp(dir->next->name, oldname) == 0 ||
			strcmp(dir->name, oldname) == 0) {
				Dir *deleted_dir = dir->next;
				dir->next = dir->next->next;

				free(deleted_dir->name);
				deleted_dir->name = strdup(newname);
				Dir *current_dir = parent->head_children_dirs;
				while (current_dir) {
					if (!current_dir->next) {
						deleted_dir->next = NULL;
						current_dir->next = deleted_dir;
						return;
					}
					current_dir = current_dir->next;
				}
			}

		dir = dir->next;
	}
}

void mv(Dir* parent, char *oldname, char *newname)
{
	int ok = verify_existence(parent, oldname, newname);
	if (!ok)
		return;

	mv_file(parent, oldname, newname);
	mv_dir(parent, oldname, newname);
}
