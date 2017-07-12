FROM frolvlad/alpine-python3

ARG NUMPY_VERSION=1.12.1
ENV NUMPY_VERSION ${NUMPY_VERSION}

ARG PANDAS_VERSION=0.19.2
ENV PANDAS_VERSION ${PANDAS_VERSION}

ARG SCIPY_VERSION=0.19.0
ENV SCIPY_VERSION ${SCIPY_VERSION}

ARG SCIKIT_VERSION=0.18.1
ENV SCIKIT_VERSION ${SCIKIT_VERSION}

RUN apk add --no-cache libstdc++ lapack-dev && \
    apk add --no-cache \
        --virtual=.build-dependencies \
        g++ gfortran musl-dev \
        python3-dev && \
    ln -s locale.h /usr/include/xlocale.h && \
    pip install -Iv numpy==$NUMPY_VERSION && \
    pip install -Iv pandas==$PANDAS_VERSION && \
    pip install -Iv scipy==$SCIPY_VERSION && \
    pip install -Iv scikit-learn==$SCIKIT_VERSION && \
    find /usr/lib/python3.*/ -name 'tests' -exec rm -r '{}' + && \
    rm /usr/include/xlocale.h && \
    rm -r /root/.cache && \
    apk del .build-dependencies
