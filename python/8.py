
LINES = []
with open("../input/8.txt", "r") as inputfile:
    for line in inputfile:
        LINES.append(line)

def run(lines):
    acc = 0
    visited = []
    index = 0

    while index not in visited and index < len(lines):
        visited.append(index)

        ins = lines[index][:3]
        arg = int(lines[index][4:])

        if ins == "acc":
            acc += arg
            index += 1
        elif ins == "jmp":
            index += arg
        else:
            index += 1

    return acc, visited, index >= len(lines), index

def part1():
    acc, _, _, _  = run(LINES)
    print(acc)

def part2():
    _, v, _, _ = run(LINES)

    for i in v:
        lines = LINES[:]
        if LINES[i][:3] == "jmp":
            lines[i] = "nop" + LINES[i][3:]
        elif LINES[i][:3] == "nop":
            lines[i] = "jmp" + LINES[i][3:]

        a, vi, s, I = run(lines)
        if s:
            print(a)

part1()
part2()
