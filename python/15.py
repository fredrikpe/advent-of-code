

def nth_number(sequence, N):
    last_seen = {n:i for i, n in enumerate(sequence[:-1])}
    cur = sequence[-1]
    for i in range(len(sequence) - 1, N - 1):
        if cur in last_seen:
            nex = i - last_seen[cur]
        else:
            nex = 0
        last_seen[cur] = i
        cur = nex

    return cur


print(nth_number([2,1,10,11,0,6], 2020))
print(nth_number([2,1,10,11,0,6], 30000000))
