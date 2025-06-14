ARG from
FROM $from as pyenv

ARG cuda
ARG python_version
ENV PYENV_ROOT="/opt/pyenv"

RUN git clone --depth 1 --branch v2.6.1 https://github.com/pyenv/pyenv.git $PYENV_ROOT &&\
    echo "PYENV_ROOT=$PYENV_ROOT" >> /root/.bashrc &&\
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc &&\
    echo 'eval "$(pyenv init -)"' >> /root/.bashrc &&\
    echo 'PATH=$PYENV_ROOT/shims:$PATH' >> /root/.bashrc &&\
    $PYENV_ROOT/bin/pyenv install $python_version && $PYENV_ROOT/bin/pyenv global $python_version &&\
    $PYENV_ROOT/shims/pip install --upgrade pip

ENV PATH $PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
