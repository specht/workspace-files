#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <ncurses.h>

#define WIDTH 40
#define HEIGHT 20

int x, y, fruitX, fruitY, score;
int tailX[100], tailY[100];
int nTail;
enum eDirection { STOP = 0, LEFT, RIGHT, UP, DOWN };
enum eDirection dir;

void Setup() {
    initscr();
    clear();
    noecho();
    cbreak();
    curs_set(0);

    srand(time(NULL));

    score = 0;
    dir = RIGHT; // Initialize dir to RIGHT instead of STOP
    x = WIDTH / 2;
    y = HEIGHT / 2;
    fruitX = rand() % WIDTH;
    fruitY = rand() % HEIGHT;
}

void Draw() {
    clear();

    for (int i = 0; i < WIDTH + 2; i++)
        mvprintw(0, i, "#");
    for (int i = 0; i < HEIGHT + 2; i++)
        mvprintw(i, 0, "#");
    for (int i = 0; i < HEIGHT + 2; i++)
        mvprintw(i, WIDTH + 1, "#");
    for (int i = 0; i < WIDTH + 2; i++)
        mvprintw(HEIGHT + 1, i, "#");

    mvprintw(fruitY + 1, fruitX + 1, "*");

    for (int i = 0; i < nTail; i++)
        mvprintw(tailY[i] + 1, tailX[i] + 1, "o");

    mvprintw(y + 1, x + 1, "S");

    mvprintw(HEIGHT + 3, 0, "Score: %d", score);

    refresh();
}

void Input() {
    keypad(stdscr, TRUE);
    halfdelay(1);

    int c = getch();

    switch (c) {
        case KEY_LEFT:
            dir = LEFT;
            break;
        case KEY_RIGHT:
            dir = RIGHT;
            break;
        case KEY_UP:
            dir = UP;
            break;
        case KEY_DOWN:
            dir = DOWN;
            break;
        case 'q':
            dir = STOP;
            break;
    }
}

void Logic() {
    int prevX = tailX[0];
    int prevY = tailY[0];
    int prev2X, prev2Y;
    tailX[0] = x;
    tailY[0] = y;

    for (int i = 1; i < nTail; i++) {
        prev2X = tailX[i];
        prev2Y = tailY[i];
        tailX[i] = prevX;
        tailY[i] = prevY;
        prevX = prev2X;
        prevY = prev2Y;
    }

    switch (dir) {
        case LEFT:
            x--;
            break;
        case RIGHT:
            x++;
            break;
        case UP:
            y--;
            break;
        case DOWN:
            y++;
            break;
    }

    if (x >= WIDTH)
        x = 0;
    else if (x < 0)
        x = WIDTH - 1;

    if (y >= HEIGHT)
        y = 0;
    else if (y < 0)
        y = HEIGHT - 1;

    for (int i = 0; i < nTail; i++) {
        if (tailX[i] == x && tailY[i] == y) {
            dir = STOP;
            break;
        }
    }

    if (x == fruitX && y == fruitY) {
        score++;
        fruitX = rand() % WIDTH;
        fruitY = rand() % HEIGHT;
        nTail++;
    }
}

int main() {
    Setup();

    while (dir != STOP) {
        Draw();
        Input();
        Logic();
    }

    endwin();

    return 0;
}