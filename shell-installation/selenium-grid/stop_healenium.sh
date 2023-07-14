#!/bin/bash

kill $(cat ./pid-hlm-backend.file) $(cat ./pid-hlm-proxy.file) $(cat ./pid-selector.file)