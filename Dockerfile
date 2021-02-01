# See https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=linux
FROM mcr.microsoft.com/dotnet/runtime:3.1

ARG BuildDirectory="./out"

# Inspired by vscode docker files: this adds a non-root user
# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's UID/GIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=foo
ARG GROUPNAME=$USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Copy
# NB: Can't use chown in add or copy: https://github.com/moby/moby/issues/35018
WORKDIR /app
COPY ${BuildDirectory} .

# Create a non-root user
RUN addgroup --gid ${USER_GID} ${GROUPNAME} \
    && adduser --shell /bin/sh --disabled-password --gecos "" --uid ${USER_UID} --ingroup ${GROUPNAME} ${USERNAME} \
    && chown -R ${GROUPNAME}:${USERNAME} ./ \
    && chmod +x ./GitVersionSysDrawingIssue \
    #
    # This is so that we don't need to play with continuation character on the last command :)
    && true

# Change the current user
USER ${GROUPNAME}:${USERNAME}

# Minimalistic test showing the app runs
RUN ls -al
RUN ./GitVersionSysDrawingIssue

# As per https://github.com/dotnet/aspnetcore/issues/5932#issuecomment-439330201
# The line below is required to handle 'real' graceful shutdown in the case of .NET Core applications
# We are replacing the default 'SIGTERM' Docker usually sends with 'SIGINT' (equivalent to Ctrl+C)
# See also https://docs.docker.com/engine/reference/builder/#stopsignal
STOPSIGNAL SIGINT

CMD ["./GitVersionSysDrawingIssue"]