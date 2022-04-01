import sys
import click
#import yaml


# get arguments for total number of people and number of people in a group.
# generate expected vote result for yaml.
# import yaml
# draw plot.

#@click.group()
#def run():
#    pass

@click.command()
@click.argument('total_number_of_people')
@click.argument('number_of_people_in_a_group')
def run(total_number_of_people, number_of_people_in_a_group):
    print('total_number_of_people: {}, number_of_people_in_a_group: {}'.format(total_number_of_people, number_of_people_in_a_group))
    if(total_number_of_people < number_of_people_in_a_group) :
        sys.exit("[Error] total_number_of_people must be smaller than the number of people_in_a_group.")

    

def printError(msg) :
    print("[Error] : {}".format(msg))

if __name__ == "__main__" :
    run();
