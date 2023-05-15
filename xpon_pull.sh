#!/bin/bash
#branch=$1
for repo in `ls .`
do
    if [ -d "./$repo" ]
    then
        printf "\n=================> cd to repo:%b <=================\n" $repo
        cd $repo
        git stash
        git co develop
        git pl
        git stash pop
        printf "=================> done for repo:%b <=================\n" $repo
        cd ..
    fi
done

#printf "=================> cd to repo tools/jenkins_scripts <=================\n"
#cd tools/jenkins_scripts
#git checkout $branch
#git pull
#cd ../..
#printf "=================> change berwick repo branch <=================\n"
#git checkout $branch
#git pull

