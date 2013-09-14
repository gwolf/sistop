#include<iostream.h>
#include<string.h>
enum color{red,yellow,green};
int main(){
int i=0,counter=0; // counters
int n; //n processes
color semaphore;
    printf("The driver requests the opening of the door\n");
    printf("how many cars there?");
    scanf("%d", &n); 
    while(counter<n)
    {
        semaphore=green;
        printf("The door opened, the car can pass");
        cin.get();
        semaphore=yellow;
        printf("The car should stop by. a pedestrian, the garage closes, another car");
           for(i=0;i<500000000;i++);  //Time sleep
        semaphore=red;
        printf("The car is stop");

        for(i=0;i<500000000;i++); //Time sleep

    counter++;
}
return 0;
}
