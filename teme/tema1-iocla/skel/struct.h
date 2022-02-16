// Copyright 2021 - 2022 321CA Soare Mihai Daniel
#ifndef _STRUCT_H
#define _STRUCT_H

struct Dir;
struct File;

typedef struct Dir {
	char *name;
	struct Dir* parent;
	struct File* head_children_files;
	struct Dir* head_children_dirs;
	struct Dir* next;
} Dir;

typedef struct File {
	char *name;
	struct Dir* parent;
	struct File* next;
} File;

#endif
