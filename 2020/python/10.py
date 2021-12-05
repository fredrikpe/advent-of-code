
TEST_LINES = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

LINES = []
with open("../input/10.txt", "r") as infile:
    for line in infile:
        if len(line) > 0:
            LINES.append(int(line))


def part1(inp):
    inp.sort()
    c = 0
    diff = {1: 0, 3: 1}
    for i in inp:
        d = abs(i - c)
        if d in diff:
            diff[d] += 1
        c = i
    return diff[1] * diff[3]


def paths_from(adjacency_list, start, stop):
    paths = {start: 1}

    v = set()
    q = [start]
    while len(q) > 0:
        current = q.pop()
        if current in v:
            continue
        v.add(current)
        for node in adjacency_list[current]:
            q.append(node)
            if node in paths:
                paths[node] += paths[current]
            else:
                paths[node] = paths[current]
        q.sort()

    return paths


def relations(elem, inp):
    return [y for y in range(elem - 3, elem) if y in inp or y == 0]


def make_adjacency_list(inp):
    al = { 0: [] }
    for line in inp:
        al[line] = relations(line, inp)
    return al


def part2(inp):
    adjacency_list = make_adjacency_list(inp)

    max_elem = max(inp) + 3
    adjacency_list[max_elem] = relations(max_elem, inp)

    return paths_from(adjacency_list, max_elem, 0)[0]

print(part1(LINES))
print(part2(LINES))

