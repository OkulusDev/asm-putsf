# asm-putsf
Реализация printf для C на языке ассеблера (компилятор FASM)

## Установка

[Релизы программы]: https://github.com/OkulusDev/asm-putsf/releases

У вас должна быть 64 битная Linux-система (если у вас другая система, измените код, если у вас другая разрядность, то измените регистры в коде).

Также у вас должен быть установлен gnu-линковщик, fasm (flat assembly) и система сборки make

```bash
# Клонирование репозитория
git clone https://github.com/OkulusDev/asm-putsf.git
cd asm-putsf

# компиляция и линковка
make build clean

# запуск
make run
```

## Пример использования

Пример кода:

```c
typedef long long int int64_t;

extern void c_exit(int ret);
extern int64_t c_putsf(char *fmt, ...);

void _start(void) {
    char *string = "PutsF";
    int64_t decimal = 123;
    char symbol = '!';

    int64_t ret = c_putsf(
        "{ %s, %d, %c }\n",
        string, decimal, symbol
    );
    c_putsf("%d\n", ret); // print 3

    c_exit(0);
}
```

Компиляция:

```bash
fasm src/putsf.asm bin/putsf.o
fasm src/c_putsf.asm bin/c_putsf.o
fasm src/c_exit.asm bin/c_exit.o
gcc -nostdlib -o bin/putsf.bin bin/putsf.o bin/c_putsf.o bin/c_exit.o bin/putsf_example.c
```

## Поддержка
Если у вас возникли сложности или вопросы по использованию Metalfish OS, создайте 
[обсуждение](https://github.com/OkulusDev/asm-putsf/issues/new/choose) в данном репозитории или напишите на электронную почту <bro.alexeev@gmail.com>.

