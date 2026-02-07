#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

/* Signal handlers */
void handle_sigterm(int sig) {
    printf("Parent received SIGTERM (signal %d). Handling gracefully.\n", sig);
}

void handle_sigint(int sig) {
    printf("Parent received SIGINT (signal %d). Exiting gracefully.\n", sig);
    exit(0);
}

int main() {
    pid_t child1, child2;

    printf("Parent process running. PID: %d\n", getpid());

    /* Register signal handlers */
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    /* First child sends SIGTERM after 5 seconds */
    child1 = fork();
    if (child1 == 0) {
        sleep(5);
        printf("Child 1 sending SIGTERM to parent.\n");
        kill(getppid(), SIGTERM);
        exit(0);
    }

    /* Second child sends SIGINT after 10 seconds */
    child2 = fork();
    if (child2 == 0) {
        sleep(10);
        printf("Child 2 sending SIGINT to parent.\n");
        kill(getppid(), SIGINT);
        exit(0);
    }

    /* Parent runs indefinitely */
    while (1) {
        pause();   // Wait for signals
    }

    return 0;
}
