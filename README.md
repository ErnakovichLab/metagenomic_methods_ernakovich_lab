# metagenomic_methods_ernakovich_lab
A repository to store example code (and maybe a future pipeline) for metagenomic analyses. 

# Getting Started

## Install conda environment
To install all the packages you'll need to run the code in this repository, use the conda environment below.
**This step is optional, but there's no guarantee that you'll be able to install the necessary packages outside of the
conda environment.**

``` bash
git clone git@github.com:ErnakovichLab/metagenomic_methods_ernakovich_lab.git
cd metagenomic_methods_ernakovich_lab
module load anaconda/colsa # only use this if working on Premise HPC system
conda env create -f metagenomic_methods_ernakovich_lab.yml --force
conda activate metagenomic_methods_ernakovich_lab_vX
```

## A note about raw data
To protect the integrity of the data you are working from, it's best practice to create symlinks in a folder called `data` to the location of these files in your system. You can do this with raw read data, databases, or other data you need.

Example:

```bash
cd data
ln -s </mnt/home/ernakovich/shared/sequencing_data/path/to/raw_reads> raw_reads
```

Large files or folders should also be added here as symlinks and to `.gitignore`.

## How to update the conda environment with a new tool
1. Go to https://anaconda.org and search for the tool you want to install. Once you find the tool's name, you know it's an anaconda package and can be added to the `metagenomic_methods_ernakovich_lab.yml` file
2. Using a branch (and tracking changes) open the .yml file and add the name under the "dependencies:" section. If the tool is in a channel that's not listed in the channels, be sure to also add that channel (most tools we use will be in either conda-forge, bioconda, or defaults - please make sure to add the channel after conda-forge and bioconda, as the order may matter for many of the tools we use). 
3. Save the yaml file and run the code below to update your conda environment. 
``` bash
deactivate;
conda env update -f whatever.yml;
source activate my_environment_name;
```
4.  If the update is successful and you are able to test and use the tool and think others will find it useful, add and commit your changes and push them to the repository for approval (see the github workflow section below for more information on how to do this).

## Git Workflow Instructions

It's easiest to work on a branch and then merge that branch with `main` when you have finished. Once you have added some code to your branch that is ready to share, push the branch to github, and create a pull request. Tag someone else in your pull request for review of the code.

<details>
  <summary>Click me to see the a brief git tutorial if you want to know how to do this</summary>

To create a branch:
```
git checkout -b <branch name>

```

You can switch back to the main branch anytime by typing 
```
git checkout main
```

### The typical git workflow

1. Edit code, test, save as normal
2. When you are ready to commit your changes, first check the status of your repository `git status`, you'll see if there are modified files that need to be commited or changes that should be pulled down.
3. _Stage_ the files for committing `git add <file name>`
4. After staging the files for committing, you can actually _commit_. I find it easiest to write committ messages inline with the `-m` command. `git commit -m "<insert a message about what you did here>"`. All of the changes in the files you staged will be committed.
5. But wait! All of these committs have only happened locally on your own computer. To share them with others, we need to push them to the cloud. You can push your branch to github with the following command. 
`git push`. (Note: the first time you do this, you may need to create a remote version of the branch, with this command `git push --set-upstream origin <branch name>`)

All in all it looks like this
```
# Make sure you're working on your branch:
git status
git checkout <branch name>
# Edit files, update, save, etc. 
# When you're ready to commit files, stage them first
git add <myfile.R>
git add <mysecondfile.R>
# Now commit and add a message about your changes
git commit -m "Adding myfile and mysecondfile to the analysis."
# Push your changes to github
git push
```
Once you have pushed your branch you may want to merge it with the main branch. This can easily be done on github by clicking the "Create pull request" button that appears when you push new changes to a branch.

### Incorperating others' changes

What if the main branch has been updated and you want to incorperate others' changes into your branch? You can do this by merging the main branch into your branch. 

1. First make sure that any changes you've made to tracked files are committed by following the ses:
[Typical git workflow](#the-typical-git-workflow) above.
2. Then make sure that any changes that have been made remotely have been incorperated into your local repository. `git pull`. If you see "Already up to date", you're good to go!. Make sure to check this for the main branch and for your own branch (if you're making changes in multiple locations.) (Changing branches with `git checkout <branch name>`)
3. Now that you have updated your code base with any remote changes, you are ready to merge the main branch into your branch. Move to your branch using `git chekcout <branch name>`. Then merge the main branch into yours with `git merge main`. Optionally, you can then push the updated version of your branch to the remote repository, with `git push`.

All in all, it looks something like this:
```
# move over to the main branch
git checkout main
# pull changes from github
git pull
# move over to your branch
git checkout <branch name>
# merge the changes you pulled to your branch
git merge main
# optionally update the remote version of your branch
git push
```
</details>
