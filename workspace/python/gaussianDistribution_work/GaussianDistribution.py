import sys
import click
import random


# get arguments for total number of people and number of people in a group.
# generate expected vote result for yaml.
# import yaml
# draw plot.

#@click.group()
#def run():
#    pass

@click.command()
@click.option('--total', help='total_number_of_people')
@click.option('--group', help='number_of_people_in_a_group')
def run(total, group):
    vTotal = int(total)
    vGroup = int(group)

    print('total_number_of_people: {}, number_of_people_in_a_group: {}'.format(vTotal, vGroup))
    if(vTotal < vGroup) :
        sys.exit("[Error] total_number_of_people must be smaller than the number of people_in_a_group.")


    repeat_cnt = vTotal / vGroup if vTotal % vGroup == 0 else vTotal / vGroup + 1
    print(repeat_cnt)

    for i in range(int(repeat_cnt)) :
        nSelectZero = 0
        nSelectOne = 0
        for j in range(vGroup) :
            v = random.randrange(0,2)
            assert(v == 0 or v == 1)
            if(v == 0) :
                nSelectZero = nSelectZero + 1
            else :
                nSelectOne = nSelectOne + 1
        rZero = nSelectZero / vGroup
        rOne = 1 - rZero
        print("select zero : {}, select one : {}".format(rZero, rOne))


def printError(msg) :
    print("[Error] : {}".format(msg))

if __name__ == "__main__" :
    run();
