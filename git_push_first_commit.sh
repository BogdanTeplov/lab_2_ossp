if [ "$#" -ne 2 ]; then
  echo "Використання: $0 <шлях до каталогу> <url до віддаленого репозиторію>"
  exit 1
fi

LOCAL_DIR=$1
REMOTE_REPO=$2

if [ ! -d "$LOCAL_DIR" ]; then
  echo "Помилка: Каталог '$LOCAL_DIR' не існує"
  exit 1
fi


cd "$LOCAL_DIR" || exit 1


if [ ! -d ".git" ]; then
  git init
fi

git add .

git commit -m "Initial commit"

git remote add origin "$REMOTE_REPO" 2>/dev/null || git remote set-url origin "$REMOTE_REPO"
git branch -M main 2>/dev/null


git push -u origin main
