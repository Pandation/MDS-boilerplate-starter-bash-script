#!/bin/bash

function chooseFrontStack {
    #ADD QWIK, REACTBRICKS, REACT
    FRONT_STACK_OPTIONS="Next";
    echo "Selection de la stack front:"
    select frontStack in $FRONT_STACK_OPTIONS;
    do
        FRONT_STACK="$frontStack";
        break;
    done
}

function chooseBackStack () {
    #ADD EXPRESS NEST
    BACK_STACK_OPTIONS="Next";
    echo "Selection de la stack back:"
    select backStack in $BACK_STACK_OPTIONS;
    do
        BACK_STACK="$backStack";
        break;
    done
}




#[NAME OF PROJECT]
PROJECT_NAME=""
if [ -n "$1" ];
then
    PROJECT_NAME=$1
else
    while [ "$PROJECT_NAME" = "" ];
    do
        echo "Nom de l'application? (slug friendly)"
        read PROJECT_NAME
    done
fi


APP_TYPE="";
OPTIONS="FRONT BACK FULLSTACK";
select opt in $OPTIONS;
do
    APP_TYPE=$opt;
    break;
done

#[STACKS OPTIONS]
FRONT_STACK="";
BACK_STACK="";
case $APP_TYPE in
    "FRONT")
        chooseFrontStack
    ;;
    "BACK")
        chooseBackStack
    ;;
    "FULLSTACK")
        chooseFrontStack
        chooseBackStack
    ;;
esac



#[RESUME APP CONFIG]
echo "Application :"
echo "Name      $PROJECT_NAME"
echo "Type      $APP_TYPE"
echo "Stack"
[ -n "$FRONT_STACK" ] && echo "-> Front  $FRONT_STACK"
[ -n "$BACK_STACK" ] && echo "-> Back  $BACK_STACK"

#ENV=DEV ->
## if [ 5 -gt 10 ];
## then

#[CLONE THE REPO(S) THEN CREATE THE NEW ONE FOR PROJECT(S)]
GITHUB_USERNAME="ADD YOUR ACCOUNT USERNAME"

if [[ "$APP_TYPE" = "FULLSTACK" || "$APP_TYPE" = "FRONT" ]];
then
    git clone https://github.com/$GITHUB_USERNAME/starter-$FRONT_STACK.git ./$PROJECT_NAME-client
    gh repo create "$PROJECT_NAME-client" --private
fi

if [[ "$APP_TYPE" = "FULLSTACK" || "$APP_TYPE" = "BACK" ]];
then
    if [[ "$FRONT_STACK" != "Next" || "$BACK_STACK" != "Next" ]];
    then
        git clone https://github.com/$GITHUB_USERNAME/starter-$BACK_STACK.git ./$PROJECT_NAME-server
        gh repo create "$PROJECT_NAME-server" --private
    fi
fi

#[INSTALL THE PACKAGES AND PUSH THE PROJECT TO THEIR REPOS]
##FRONT
if [[ "$APP_TYPE" = "FULLSTACK" || "$APP_TYPE" = "FRONT" ]];
then
    cd $PROJECT_NAME-client
    git remote rm origin
    git remote add origin https://github.com/$GITHUB_USERNAME/$PROJECT_NAME-client.git
    git branch -M master
    git push -u origin master
    npm install
fi


##BACK
if [[ "$APP_TYPE" = "FULLSTACK" || "$APP_TYPE" = "BACK" ]];
then
    if [[ "$FRONT_STACK" != "Next" || "$BACK_STACK" != "Next" ]];
    then
        cd ../$PROJECT_NAME-server
        git remote rm origin
        git remote add origin https://github.com/$GITHUB_USERNAME/$PROJECT_NAME-client.git
        git branch -M master
        git push -u origin master
        npm install
    fi
fi


#[CREATE FILE(S) CONFIG]
# FRONT
# use PLOPjs to create all controllers and redux features MUAHAHAHAHAHA


#ENV=DEV
##fi