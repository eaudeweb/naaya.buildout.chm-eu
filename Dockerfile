from eaudeweb/naayaos:16.11.18

ENV ZOPE_HOME /var/local/chm
WORKDIR $ZOPE_HOME

RUN yum -y updateinfo && yum -y install lynx && yum clean all

COPY bootstrap.py $ZOPE_HOME/
COPY buildout.cfg $ZOPE_HOME/
COPY versions.cfg $ZOPE_HOME/
COPY zope-2.12.28-versions.cfg $ZOPE_HOME/
COPY crontab.cfg $ZOPE_HOME/
COPY docker-entrypoint.sh /

RUN /var/local/python/python26/bin/python ./bootstrap.py --version=1.4.4 \
 && bin/buildout \
 && mkdir -p $ZOPE_HOME/var/log \
 && touch $ZOPE_HOME/var/log/instance.log \
 && touch $ZOPE_HOME/var/log/instance-Z2.log \
 && touch $ZOPE_HOME/var/log/zeoserver.log \
 && chown zope:zope -R .

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
