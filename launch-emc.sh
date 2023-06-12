#!/bin/bash
docker run -d -p 127.0.0.1:41879:41879 -p 41878:41878 --name emc -ti \
  emc 