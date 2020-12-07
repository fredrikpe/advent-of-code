lines = []
with open("../input/7.txt", "r") as inputfile:
    for line in inputfile:
        lines.append(line)


def part1():
    nodes = set()
    targets = set(["shiny gold"])

    while len(targets) > 0:
        new_targets = set()

        for line in lines:
            for target in targets:
                if target in line[1:]:
                    node = line.split("bags con")[0]
                    new_targets.add(node)

        nodes.update(new_targets)
        targets = new_targets

    return len(nodes)


print(part1())
