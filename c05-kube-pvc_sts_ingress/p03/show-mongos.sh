#!/bin/bash -v
seq 0 1 | xargs -tI@ kubectl exec mongos-@ -- mongo --eval="rs.isMaster()"|grep master
