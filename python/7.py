
dag = {}
inverse_dag = {}
with open("../input/7.txt", "r") as inputfile:
    for line in inputfile:
        words = line.split(" ")
        if len(words) == 7 or len(words) < 2:
            continue

        root = words[0] + " " + words[1]
        dag[root] = []

        while len(words) > 5:
            words = words[4:]

            count = int(words[0])
            leaf = words[1] + " " + words[2]

            if leaf in inverse_dag:
                inverse_dag[leaf].append(root)
            else:
                inverse_dag[leaf] = [root]

            dag[root].append((count, leaf))

def part1():
    return len(part1_inner("shiny gold")) - 1

def part1_inner(target):
    if target not in inverse_dag:
        return [target]

    return set([target]).union(*(part1_inner(leaf) for leaf in inverse_dag[target]))


def part2():
    return part2_inner(1, "shiny gold") - 1

def part2_inner(m, target):
    if target not in dag:
        return m

    return m + sum([(part2_inner(m * f, s)) for (f, s) in dag[target]])


print(part1())
print(part2())
