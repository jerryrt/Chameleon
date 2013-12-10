#!/bin/bash

for PRJ in $(echo "UIKit StoreKit MessageUI AVFoundation AddressBookUI AssetsLibrary MediaPlayer")
do
    echo building project $PRJ using xcodebuild ...
    cd $PRJ
    xcodebuild -scheme $PRJ archive
    cd ..
done
