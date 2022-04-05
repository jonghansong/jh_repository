import sys
import click
import random
import yaml

# draw plot.

@click.command()
@click.option('--total', help='total_number_of_people')
@click.option('--group', help='number_of_people_in_a_group')
@click.option('--file', default="out.yaml", help='temp yaml file name')
def run(total, group, file):
    vTotal = int(total)
    vGroup = int(group)

    print('total_number_of_people: {}, number_of_people_in_a_group: {}'.format(vTotal, vGroup))
    if(vTotal < vGroup) :
        sys.exit("[Error] total_number_of_people must be smaller than the number of people_in_a_group.")

    out = {}
    runRandomSelect(vTotal, vGroup, out)

    with open(file, 'w') as f:
        yaml.dump(out, f)

    drawGraph(file)

def drawGraph(file_name) :
    with open(file_name) as f:
        context = yaml.load(f, Loader=yaml.FullLoader)

    classified_r = {}
    for k0, v0 in context.items() :
        if(type(v0) is not dict) : continue

        for k1, v1 in v0.items() :
            if(not k1 in classified_r.keys()) :
                classified_r[k1] = []
                classified_r[k1].append(v1)
            else :
                classified_r[k1].append(v1)


def runRandomSelect(total, group, out) :
    repeat_cnt = total / group

    for i in range(int(repeat_cnt)) :
        nSelectZero = 0
        nSelectOne = 0
        for j in range(group) :
            v = random.randrange(0,2)
            assert(v == 0 or v == 1)
            if(v == 0) :
                nSelectZero = nSelectZero + 1
            else :
                nSelectOne = nSelectOne + 1
        rZero = nSelectZero / group
        rOne = 1 - rZero
        out[i] = {0:rZero, 1:rOne}

    share = total % group
    if(share != 0) :
        nSelectZero = 0
        nSelectOne = 0
        for i in range(share) :
            v = random.randrange(0,2)
            assert(v == 0 or v == 1)
            if(v == 0) :
                nSelectZero = nSelectZero + 1
            else :
                nSelectOne = nSelectOne + 1
        rZero = nSelectZero / group
        rOne = 1 - rZero

        keys = out.keys()
        last = list(keys)[-1]
        out[last+1] = {0:rZero, 1:rOne}

def printError(msg) :
    print("[Error] : {}".format(msg))

if __name__ == "__main__" :
    run();
