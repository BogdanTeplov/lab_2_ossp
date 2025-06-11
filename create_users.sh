users=("alice" "bob" "charlie")  

for username in "${users[@]}"; do  
    if [ -d "/home/$username" ]; then
        echo "Користувач '$username' вже існує. Пропускаємо..."  
        continue
    fi

    echo "Створюємо користувача: $username"

    sudo useradd -m "$username"  

    password=$(openssl rand -base64 12)  
    echo "$username:$password" | sudo chpasswd  

    echo "$password" > "${username}_password.txt"  
    echo "Пароль для $username збережено у ${username}_password.txt"

    sudo -u "$username" ssh-keygen -t rsa -b 2048 -N "" -f "/home/$username/.ssh/id_rsa"  

    echo "SSH ключі створено для $username"
done
