# Create a directory and cd into it.
# If multiple directories are give, create them all and cd into the last one.
function take() {
	mkdir -p $@ && cd ${@:$#}
}
