FROM 	vedarth/sles

COPY 	./spark-ui-proxy.py /

RUN	zypper update -y
RUN zypper install -y python

ENV 	SERVER_PORT=8080
ENV 	BIND_ADDR="0.0.0.0"

EXPOSE 	8080

ENTRYPOINT ["python", "/spark-ui-proxy.py"]
