import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from py_utils import fileparts
import os
import click

# Creates a list of arguments that will be used in command line execution
@click.command()
@click.option('--input_data', prompt='Input ', help='Complete path for csv input')
@click.option('--out_format', default = ".png", help = 'Format of output images. Example: "png", "svg", "jpg"...')
@click.option('--out_fd', default = "", help = 'Output folder.')

def main(input_data, out_format, out_fd):
    # Check if input file exists
    if os.path.isfile(input_data):        
        data = pd.read_csv(input_data)
    else:
        print('Check if input file exists.')

    # Degree
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(40,30))

    ax = sns.barplot(x = data["ROIs"], y = data["Degree"], hue=data["Classes"])
    ax.set_title("Degree")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)
    plt.xticks(rotation=90)

    figname = "Degree_GTM" + out_format
    plt.savefig(os.path.join(out_fd,figname))
    plt.close(fig)

    # Strength
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(40, 30))

    ax = sns.barplot(x = data["ROIs"], y = data["Strength"], hue=data["Classes"])
    ax.set_title("Strength")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)
    plt.xticks(rotation=90)

    figname = "Strength_GTM" + out_format
    plt.savefig(os.path.join(out_fd,figname))
    plt.close(fig)

    # Local_Efficiency
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(40,30))

    ax = sns.barplot(x = data["ROIs"], y = data["Local_Efficiency"], hue=data["Classes"])
    ax.set_title("Local_Efficiency")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)
    plt.xticks(rotation=90)

    figname = "LocalEfficiency_GTM" + out_format
    plt.savefig(os.path.join(out_fd,figname))
    plt.close(fig)

    # Betweenness_Centrality
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(40,30))

    ax = sns.barplot(x = data["ROIs"], y = data["Betweenness_Centrality"], hue=data["Classes"])
    ax.set_title("Betweenness_Centrality")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)
    plt.xticks(rotation=90)

    figname = "BetweenessCentrality_GTM" + out_format
    plt.savefig(os.path.join(out_fd,figname))
    plt.close(fig)

    # Flow_coefficient
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(40,30))

    ax = sns.barplot(x = data["ROIs"], y = data["Flow_coefficient"], hue=data["Classes"])
    ax.set_title("Flow_coefficient")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)
    plt.xticks(rotation=90)

    figname = "FlowCoefficient_GTM" + out_format
    plt.savefig(os.path.join(out_fd,figname))
    plt.close(fig)    

if __name__ == '__main__':
    main()
