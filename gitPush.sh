###rsing Arguments
##############################################################################################
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -u |--useremail)
    GITHUBUSER="$2"
    shift # past argument
    ;;
    -m |--message)
    MSG="$2"
    shift # past argument
    ;;

esac
shift # past argument or value
done

if [ -z $GITHUBUSER ]; then
    echo "You must provide github user's email address"
    echo " ./gitPushThisFolder.sh -u <EMAILADDRESS>"
    echo
   exit
fi 

#BRANCHNAME=$(pwd | awk  -F/ '{print $NF}')
BRANCHNAME=$(git branch | grep ^[*] | awk -F'* ' '{print $2}')

if [ -z $MSG ]; then
    echo "You are executing a push operation without name/message"
    echo "Using default:$BRANCHNAME"
    MSG="$BRANCHNAME" 
    echo "If you want to spcify a message/name, do it as follows:"
    echo " ./gitPushThisFolder.sh -u <EMAILADDRESS> -m <SINGLEWORDMESSAGE>"

fi 



echo
echo
echo "!!!!!!!!!IMPORTANT!!!!!!!!!"
echo
echo
echo "This will commit and push all your files to Github."
echo "Branch Name is: $BRANCHNAME"
echo "Push Message is:  $MSG"
echo "Github User is : $GITHUBUSER"
echo
echo
read -p "Are you sure to continue? [N]? " -n 1 -r
echo
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    git config --global user.email ""$GITHUBUSER""
    rm -f deployment-branch-*
    git rm deployment-branch-* 
    git add . 
    git commit -m ""$MSG""
    git push -u origin "$BRANCHNAME"
    exit
fi

echo "Github Push operation cancelled"
exit
