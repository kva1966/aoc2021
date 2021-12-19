FROM perl:5.34

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install time && \
    apt-get autoremove && \
    apt-get clean

WORKDIR /app

COPY cpanfile ./build/
RUN cpanm --installdeps ./build/

ENV PERL5OPT="-MCarp=verbose"
ENV PERL5LIB='/app/data/lib'

WORKDIR /app/data
ENTRYPOINT [ "perl" ]
