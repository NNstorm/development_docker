ARG from
FROM $from as conda

ARG cuda
ARG PYTHON_VERSION="3.11.7"
ENV PYENV_ROOT="/opt/pyenv"

RUN git clone --depth 1 --branch v2.3.35 https://github.com/pyenv/pyenv.git $PYENV_ROOT &&\
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc &&\
    echo 'eval "$(pyenv init -)"' >> /root/.bashrc &&\
    echo "PATH=$PYENV_ROOT/shims:$PATH" >> /root/.bashrc &&\
    $PYENV_ROOT/bin/pyenv install $PYTHON_VERSION && $PYENV_ROOT/bin/pyenv global $PYTHON_VERSION &&\
    $PYENV_ROOT/shims/pip install --upgrade pip

ENV PATH $PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
