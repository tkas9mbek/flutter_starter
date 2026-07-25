---
description: Write a Russian test note for testers/managers in Confluence markup into work/test_note.txt
---

Create a test note for testers and managers with no Flutter knowledge. Russian, plain
product language — no class names, no bloc/repository terms, no file paths. Output in
CONFLUENCE MARKUP (wiki markup: *bold*, bullet lists with *, {panel}/{info} if useful),
saved to `work/test_note.txt`.

Sources: use work/review.md and work/branch_context.md if fresh for this branch instead
of re-diffing; otherwise gather the branch summary the same way /com_read_branch does.

Screen names: use the RUSSIAN LOCALIZATION strings of each touched screen's AppBar
title — look up the title key in the screen's app bar and take the ru value from the
localization files. Never translate yourself. A key with no ru value → write the key
name and flag it at the end of the note.

Structure (adapt wording, keep the three blocks):

◽️ (Обязательно) Что сделано: что именно реализовано — минимум "Реализовано по ТЗ",
лучше 1-3 предложения по сути.

◽️ Что затронуто (Регресс): какие смежные экраны и функции могли быть затронуты, на что
обратить внимание дополнительно. Список экранов — по русской локализации из AppBar.
Включай КОСВЕННО затронутое: общие виджеты, изменённые блоки, компоненты дизайн-системы —
в пользовательских терминах.

◽️ Особенности тестирования: что реально блокирует проверку — только прод, конкретные
аккаунты/карты, реальный девайс с NFC, фича-флаги и окружение. "Нет", если нет.

In this conversation return the path and the note's full text for pasting.
