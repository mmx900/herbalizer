FROM haskell:9.0

WORKDIR /opt/herbalizer

RUN cabal update

# Add just the .cabal file to capture dependencies
COPY ./herbalizer.cabal /opt/herbalizer/herbalizer.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
RUN cabal build --only-dependencies -j4

# Add and Install Application Code
COPY . /opt/herbalizer
RUN cabal install

CMD ["herbalizer"]
