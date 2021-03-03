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
    # Number of Graph Measures
    numGM = 6

    # Number of Rows
    numRows = 2

    # Number of Columns
    ncols = round(numGM / numRows)
    ncols = int(ncols)

    # Check if input file exists
    if os.path.isfile(input_data):        
        data = pd.read_csv(input_data)
    else:
        print('Check if input file exists.')
        return
    
    fileDir, f = fileparts(input_data)

    sns.set_style("whitegrid")
    fig, axes = plt.subplots(nrows=numRows, ncols=ncols, figsize=(24, 12))

    # Global Efficiency
    ax = sns.barplot(x = data["Classes"], y = data["Global_Efficiency"], ax = axes[0][0])
    ax.set_title("Global Efficiency")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    # Assortativity Coefficient
    ax = sns.barplot(x = data["Classes"], y = data["Assortativity_Coefficient"], ax = axes[0][1])
    ax.set_title("Assortativity Coefficient")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    # Average Degree
    ax = sns.barplot(x = data["Classes"], y = data["Average_Degree"], ax = axes[0][2])
    ax.set_title("Average Degree")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    # Density
    ax = sns.barplot(x=data["Classes"], y = data["Density"], ax=axes[1][0])
    ax.set_title("Density")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    # Average Clustering Coefficient
    ax = sns.barplot(x=data["Classes"], y=data["Average_Clustering_Coefficient"], ax=axes[1][1])
    ax.set_title("Average Clustering Coefficient")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    # Small Worldness
    ax = sns.barplot(x=data["Classes"], y=data["Small_Worldness"], ax=axes[1][2])
    ax.set_title("Small Worldness")
    ax.xaxis.label.set_visible(False)
    ax.yaxis.label.set_visible(False)

    figname = f.replace(".csv", out_format)   
    
    plt.savefig(os.path.join(out_fd,figname))
    #    plt.close(fig)

if __name__ == '__main__':
    main()
