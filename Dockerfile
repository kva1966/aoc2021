FROM perl:5.34

WORKDIR /app

COPY cpanfile ./build/
RUN cpanm --installdeps ./build/

ENV PERL5OPT="-MCarp=verbose"
ENV PERL5LIB='/app/data/lib'

WORKDIR /app/data
ENTRYPOINT [ "perl" ]
