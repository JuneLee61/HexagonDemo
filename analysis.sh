# 移除原有的生成文件
xcodebuild clean | xcpretty
rm -r build
rm -r compile_commands.json
# Build和把日志写到目标文件
xcodebuild | xcpretty -r json-compilation-database --output compile_commands.json
