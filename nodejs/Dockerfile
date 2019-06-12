FROM vedarth/sles

RUN zypper update -y && \
    zypper install -y npm

EXPOSE 3000

CMD ["npm", "start"]