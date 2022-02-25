#include <stdio.h>
#include <stdlib.h>
#define MAX_LINE 100001

int expression(char *p);
int term(char *p);
int factor(char *p);

int main()
{
    char s[MAX_LINE];
    char *p;
    int i = 0;  
    scanf("%s", s);
    p = s;
    printf("%d\n", expression(p));
    return 0;
}

int get_paranthesis(char *expression)
{
    int x = 0, i = 0, no_characters = 0;

    // Scanning the expression until we reach the end
    while (expression[i]!= '\0') {
        printf("%c ", expression[i]);
        no_characters++;
        // to check the symbol is '('
        if (expression[i]=='(') {
            x++; // incrementing 'x' variable
        } else if (expression[i]==')') {
            x--; // decrementing 'x' variable
            if (x < 0) {
                break;
            }
        }
        i++; // incrementing 'i' variable.
    }
    printf("\nnr caractere: %d\n", no_characters);
    
    if (x == 0) {
        return no_characters;
    }

    return 0;
}

int factor(char *p)
{
    int i = 0;
    int start_counter = 0;
    printf("\n");
    while (p[i] != '\0') {
        printf("%c ", p[i]);
        if (p[i] == '(') {
            expression(&p[i + 1]);
            int jump = get_paranthesis(&p[i]);
            if (jump == 0)
                jump++;
            i = i + jump - 1;
        } else if (p[i] == '+') {
            break;
        } else if (p[i] == '-') {
            break;
        } else if (p[i] == ')') {
            break;
        }
        i++;
    }

    return 1;
}

int expression(char *p)
{
    int sum = 0;
    sum += factor(p);

    int i = 0;
    while (p[i] != '\0') {
        if (p[i] == '+') {
            sum += factor(&p[i + 1]);
        } else if (p[i] == '-') {
            sum -= factor(&p[i + 1]);
        }
        i++;
    }
    return sum;
}