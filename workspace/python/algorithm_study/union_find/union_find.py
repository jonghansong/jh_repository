from asyncio import events
import random

def union(set0, set1) :
    return set0 | set1

def find(n, set0) :
    return n in set0

def run():
    number_set0 = set()
    number_set1 = set()

    for i in range(20) :
        v = random.randrange(0,20)
        if v in number_set0 or v in number_set1 :
            continue

        #if v in number_set0 :
        #    number_set1.add(v)
        #    continue

        #if v in number_set1 :
        #    number_set0.add(v)
        #    continue

        if i % 2 == 0 :
            number_set0.add(v)
        else :
            number_set1.add(v)

    print(number_set0)
    print(number_set1)

    union_set = set()
    print("union_set")
    union_set = union(number_set0, number_set1)
    print(union_set)


if __name__ == "__main__":
    print("Program start")
    run();