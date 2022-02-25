int main(void)
{
	char string[MAX_STRING_SIZE];
	int err = 0;

	stack_t *stack = st_create(sizeof(char));
	fscanf(stdin, "%s", string);

	for (uint i = 0; i < strlen(string); i++) {
		if (string[i] == '(') {
			st_push(stack, &string[i]);
		} else if (st_is_empty(stack)) {
			err = 1;
			break;
		} else {
			char top_elem = *(char *)st_peek(stack);
			if ((string[i] == ')' && top_elem != '(')) {
				err = 1;
				break;
			}
			st_pop(stack);
		}
	}

	if (!err && !st_is_empty(stack))
		printf("The string has the paranthesis closed wrong\n");
	else if (!err)
		printf("The string has the paranthesis closed well\n");
	else 
		printf("The string has the paranthesis closed wrong\n");
	
	st_free(stack);

	return 0;
}

for (int i = 0; i < strlen(s); i++) {
        if (s[i] == '(' || s[i] == '[' || s[i] == '{')
            stk.push(s[i]);
        else if (stk.isEmpty()) {  			
            error = 1; break; 			// Empty stack
        } else {
            if ((s[i] == ')' && stk.peek() != '(') || 
                (s[i] == ']' && stk.peek() != '[') ||
                (s[i] == '}' && stk.peek() != '{')) {
		error = 1; break; 			// Wrong paranthesis
	  }
            stk.pop();
        }
    }
    if (!error && !stk.isEmpty())
        break; 					// Stack not empty at the end
    else if (!error)
        printf("OK\n");
