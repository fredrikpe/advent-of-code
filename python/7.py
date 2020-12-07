
tree = {}
inverse_tree = {}
with open("../input/7.txt", "r") as inputfile:
    for line in inputfile:
        words = line.split(" ")
        if len(words) == 7 or len(words) < 2:
            continue

        root = words[0] + " " + words[1]
        tree[root] = []

        while len(words) > 5:
            words = words[4:]

            count = int(words[0])
            leaf = words[1] + " " + words[2]

            if leaf in inverse_tree:
                inverse_tree[leaf].append(root)
            else:
                inverse_tree[leaf] = [root]

            tree[root].append((count, leaf))


def part1():
    nodes = set()
    targets = set(["shiny gold"])

    while len(targets) > 0:
        new_targets = set()

        for target in targets:
            if target not in inverse_tree:
                continue
            leafs = inverse_tree[target]
            new_targets.update([s for s in leafs])

        nodes.update(new_targets)
        targets = new_targets

    return len(nodes)


def part2():
    return part2_inner(1, "shiny gold") - 1

def part2_inner(m, target):
    if target not in tree:
        return m

    leafs = tree[target]
    return m + sum([(part2_inner(m * f, s)) for (f, s) in leafs])


print(part1())
print(part2())
