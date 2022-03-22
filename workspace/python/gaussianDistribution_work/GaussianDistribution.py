import click
#import yaml


# get arguments for total number of people, number of people in a group.
# generate expected vote result for yaml.
# import yaml
# draw plot.

@click.command()
@click.argument('total_number_of_people')
@click.argument('number_of_people_in_a_group')
def run(total_number_of_people, number_of_people_in_a_group):
    print("$1, $2") #total_number_of_people, number_of_people_in_a_group)
    print("Hello python")


if __name__ == "__main__" :
    run();
