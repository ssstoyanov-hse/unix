# Накатываем убунту
FROM ubuntu:latest

# Не забываем про копирайт
MAINTAINER Stanislav Stoianov <stanis.stoyanov@gmail.com>

# Настраиваем таймзону
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Обновляем данные репозиториев и ставим программы
RUN apt-get -qq -y update
RUN apt-get -qq -y install samba nginx

# Переносим конфигурацию и перевязываем ссылки на файлы
COPY samba.conf /etc/samba/samba.conf
RUN cat /etc/samba/samba.conf >> /etc/samba/smb.conf
COPY nginx-d.conf /etc/nginx/sites-available/proxy
RUN rm /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy && nginx -t

# Пробрасивыаем порты
EXPOSE 137 445 80

# Запускаем samba и nginx
CMD /etc/init.d/smbd start && nginx -g "daemon off;"
