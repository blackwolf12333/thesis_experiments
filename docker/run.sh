#!/usr/bin/env bash

docker run -it --rm -v "$PWD:/thesis" -w /thesis thesis_experiments_env:latest /bin/bash
