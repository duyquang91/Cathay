
#!/bin/bash
#Steve Dao 2019if type brew

if type slather
then
  echo "*** Skip installing slather..."
else
  echo "*** Installing slather"
  sudo gem install slather
fi

xcodebuild test -sdk iphonesimulator -destination 'platform=iOS Simulator,OS=13.2.2,name=iPhone 11' -scheme Cathay -derivedDataPath Build/ -enableCodeCoverage YES
echo "*** Creating report..."
slather coverage --show --html
