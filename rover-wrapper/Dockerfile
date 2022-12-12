
#FROM aztfmod/rover:1.0.7-2109.2410  
FROM vcflabmgmtcore.azurecr.io/rover:1.0.7-2109.2410 

ARG USERNAME=vscode
ARG GRPNAME=vscode
ARG USER_UID=1002 
ARG USER_GID=1003 

#https://www.thegeekdiary.com/how-to-correctly-change-the-uid-and-gid-of-a-user-group-in-linux/
#current:
#uid=1000(vscode) gid=1001(vscode)
#
#target :
#uid=1002(vscode) gid=1003(vscode)
#
#host vm FE:
#uid=1002(cloud) gid=1003(cloud) 

ENV CAF_LZ_PATH="/tf/caf/.solution/caf/caf_solution"


USER root

RUN groupmod -g ${USER_GID} ${GRPNAME=vscode} && \
    usermod -u ${USER_UID} -g ${USER_GID} ${USERNAME} 
    
    #usermod -aG sudo ${USERNAME}

RUN chown -R ${USER_UID}:${USER_GID} /home/${USERNAME} /tf/rover /tf/caf /tf/logs && \
    chmod 777 -R /home/${USERNAME} /tf/caf /tf/rover && \
    chmod 700 /home/${USERNAME}/.ssh && \
    echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} 

COPY rover/rover.sh /tf/rover
COPY rover/functions.sh /tf/rover
COPY rover/tfstate_azurerm.sh /tf/rover

USER ${USERNAME}
WORKDIR /tf/caf


