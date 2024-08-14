#include <stdio.h>
#include <string.h>

extern void mem_display();
extern void writeString();

int main()
{
    char *myStr = "Toi la Thanh\n";
    int l = strlen(myStr);
    //writeString(str, l);
    mem_display(myStr, l);
    /*
    int k = 0;
    while (s[k++]!=NULL);
        writeString(s, k);
    return 0;
    */
}