import sys
import click
import random
import yaml
#import numpy as np
import matplotlib.pyplot as plt

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

    dZeroR = {}
    dOneR = {}

    zero_list_x = []
    zero_list_y = []

    one_list_x = []
    one_list_y = []

    for k0, v0 in context.items() :
        if(type(v0) is not dict) : continue

        for k1, v1 in v0.items() :
            if(k1 == 0) :
                if(not v1 in dZeroR) :
                    dZeroR[v1] = 0
                dZeroR[v1] = dZeroR[v1] + 1
                zero_list_x.append(v1)
                zero_list_y.append(dZeroR[v1])
            elif(k1 == 1) :
                if(not v1 in dOneR) :
                    dOneR[v1] = 0
                dOneR[v1] = dOneR[v1] + 1
                one_list_x.append(v1)
                one_list_y.append(dOneR[v1])

    sortedDZeroR = sorted(dZeroR.items(), key = lambda item: item[1], reverse = True)
    sortedDOneR = sorted(dOneR.items(), key = lambda item: item[1], reverse = True)

    maximum = sortedDZeroR[0][1] if sortedDZeroR[0][1] > sortedDOneR[0][1] else sortedDOneR[0][1]

    plt.plot(zero_list_x, zero_list_y, 'ro')
    plt.plot(one_list_x, one_list_y, 'bo')
    plt.axis([0, 1, 0, maximum+10])
    plt.show()




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
        rOne = nSelectOne / group
        #rOne = 1 - rZero
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
