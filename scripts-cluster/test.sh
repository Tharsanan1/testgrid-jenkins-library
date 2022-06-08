#!/bin/bash
productName=$1;
relativeFilePathTestFile=$2
sh ./scripts-cluster/"$productName"/"test-$productName"/"$relativeFilePathTestFile"