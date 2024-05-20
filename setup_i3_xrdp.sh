#!/bin/bash

# Обновление системы и установка необходимых пакетов
sudo apt update
sudo apt install -y i3 xrdp dbus-x11 xorgxrdp

# Добавление пользователя xrdp в группу ssl-cert
sudo adduser xrdp ssl-cert

# Настройка xrdp.ini
sudo sed -i 's/port=3389/port=tcp:\/\/:3389/' /etc/xrdp/xrdp.ini

# Настройка Xwrapper.config
sudo bash -c 'echo "allowed_users=anybody" > /etc/X11/Xwrapper.config'

# Создание .xsession файла для пользователя
echo "exec i3" > ~/.xsession
chmod +x ~/.xsession

# Перезапуск службы xrdp и включение её автозапуска
sudo systemctl restart xrdp
sudo systemctl enable xrdp

# Настройка firewall для разрешения порта 3389
sudo ufw allow 3389
sudo ufw reload

echo "Установка и настройка завершены. Теперь вы можете подключиться к вашему серверу через RDP."
