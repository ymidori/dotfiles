# syntax=docker/dockerfile:experimental
FROM python:3.8.6-buster

RUN apt update && apt upgrade -y

RUN apt-get install zsh -y
