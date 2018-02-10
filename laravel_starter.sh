IBlack='\033[0;90m'      # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
Color_Off='\033[0m'       # Text Reset

echo
echo " ${IGreen}=============================================================="
echo " ${IGreen}|                  Create Laravel Project                    |"
echo " ${IGreen}|                     Made By: Hafiq                         |"
echo " ${IGreen}=============================================================="
echo
echo "${IGreen} Enter Project Name [${IYellow}laravel_base]"; 
echo -n "${IWhite} >${Color_Off}  "; read project_name;
project_name="${project_name:=laravel_base}"
project_name=$( tr '[A-Z]' '[a-z]' <<< $project_name)
echo
echo "${IYellow} Cloning base project from ${IGreen}https://github.com/afiqiqmal/Laravel-Base-Project.git ${IYellow}==> ${IGreen}/$project_name" 
echo 

repo="https://github.com/afiqiqmal/Laravel-Base-Project.git"

git clone "$repo" "$project_name"

if ! [ $? -eq 0 ]; then
	echo
	echo "${IRed} Failed to Clone Project to %project_name"
	echo
	echo "${IYellow} Bye Bye..."
	echo
	exit
fi

echo "${IGreen} Done Cloning..."

if ! test -d "$project_name"
	then
	echo "${IRed} Folder is not properly created"
	echo "${IYellow} Exiting..." 
	exit
fi

cd "$project_name"
cp .env.example .env

echo
echo "${IGreen} Do You Want to install composer dependencies ${IWhite}[${IGreen}Y|${IYellow}n${IWhite}] : ";
echo -n "${IWhite} >${Color_Off} "; read need_composer;
need_composer="${need_composer:=Y}"
need_composer=$( tr '[A-Z]' '[a-z]' <<< $need_composer)
if [ "$need_composer" = 'y' ] || [ "$need_composer" = 'yes' ]; then
	echo
	composer install
	if ! [ $? -eq 0 ]; then
		echo "${IRed} Composer install failed"
		echo "${IYellow} Exiting..."
		exit
	fi
	composer dump-autoload
fi	

echo
echo "${IYellow} Generating Key..."
php artisan key:generate
echo "${IGreen} Done Generate..."
echo
echo "${IGreen} Do You Want to Setup Database Connection? ${IWhite}[${IGreen}Y|${IYellow}n${IWhite}] : ";
echo -n "${IWhite} >${Color_Off} "; read need_setup;
need_setup="${need_setup:=Y}"
need_setup=$( tr '[A-Z]' '[a-z]' <<< $need_setup)
if [ "$need_setup" = 'y' ] || [ "$need_setup" = 'yes' ]; then
	echo
	php artisan setup:db
fi	

echo "${IGreen} Done Setup.. You can start to serve your project project"
echo "${IYellow} Bye Bye..."
