
#https://www.thegeekdiary.com/how-to-correctly-change-the-uid-and-gid-of-a-user-group-in-linux/

ARG USERNAME=vscode
ARG GRPNAME=vscode
ARG USER_UID=1002
ARG USER_GID=1003

groupmod -g ${USER_GID} ${GRPNAME=vscode}
usermod -u ${USER_UID} -g ${USER_GID} ${USERNAME}

groupmod -g 1003 vscode
sudo usermod -u 1002 -g 1003 vscode


current:
uid=1000(vscode) gid=1001(vscode)

target :
uid=1002(vscode) gid=1003(vscode)

host vm FE:
uid=1002(cloud) gid=1003(cloud) 



