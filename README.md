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

## Поддержка
Если у вас возникли сложности или вопросы по использованию Metalfish OS, создайте 
[обсуждение](https://github.com/OkulusDev/asm-putsf/issues/new/choose) в данном репозитории или напишите на электронную почту <bro.alexeev@gmail.com>.

