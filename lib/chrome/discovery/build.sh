#!/bin/sh

grunt

rm -rf ../app/js/discovery/flint_discovery.js
cp out/flint_discovery.js ../app/js/discovery/
