ARG ALPINE_VERSION=3.11

FROM elixir:1.10-alpine as init
# erlang 22
# OTP_VERSION="22.3.4.10" 


# This step installs all the build tools we'll need
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  git \
  build-base \
  bash

RUN mix local.hex --force && mix local.rebar --force

# By convention, /opt is typically used for applications
WORKDIR /opt/app

COPY mix.exs mix.lock ./
ENV MIX_ENV=test
RUN mix deps.get

COPY . ./
RUN mix compile

CMD ./start.sh


FROM init as builder
# The environment to build with
ENV MIX_ENV=prod

RUN mix compile

RUN mkdir -p /opt/built
RUN mix release --overwrite --path /opt/built


# From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:${ALPINE_VERSION} as production

EXPOSE 4000

# The name of your application/release (required)
ARG APP_NAME=bank_api

RUN apk update && \
  apk add --no-cache \
  bash \
  openssl-dev

ENV REPLACE_OS_VARS=true \
  APP_NAME=${APP_NAME}

WORKDIR /opt/app

COPY --from=builder /opt/built .

CMD trap 'exit' INT; /opt/app/bin/${APP_NAME} start
