
# Some Git Command Line Helpers I Use

Inspired and bits from https://github.com/Andrew565/dotfiles

Mostly bash scripts.

## gp-summary

Emits a table of info about a pile of local git repos.

Repository paths are read from an environment variable: `REPOPATHS`.  Export this variable via one of your local dot files like so: 
```
export REPOPATHS=~/Repos/github.com/AnimationMentor:~/Repos/github.com/dkujawski
```

![screen shot showing gp-summary](https://raw.githubusercontent.com/reedwade/my-git-helpers/master/gp-summary.png)

next steps - take a command line arg/glob to override the embedded list

## gp-fetch-remotes

Runs `git fetch --all` on each git repo.
