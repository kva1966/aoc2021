FROM perl:5.34

WORKDIR /app

COPY scripts ./scripts
COPY modules.txt ./build/
RUN ./scripts/install-modules.sh ./build/modules.txt

WORKDIR /app/data
ENTRYPOINT [ "perl" ]
