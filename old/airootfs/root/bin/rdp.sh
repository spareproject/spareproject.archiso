#!/bin/env bash

Xephry -screen 1900x1060 :13 &
export DISPLAY=:13
ssh -p 12724 spareproject@10.0.0.3


