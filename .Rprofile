# set repository for downloads
local({r <- getOption("repos")
	r["CRAN"] <- "https://mirrors.sorengard.com/cran/" 
	options(repos=r)})

# show curret working directory
.First <- function() {
	if(interactive()) {
		library(utils)
		timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))

	}
}

# Set default options
options(prompt="-> ")
options(continue="<~~ ")
options(width = 75)

# autoquit without asking to save
q <- function (save="no", ...) {
	quit(save=save, ...)
}

# allows for tab-completion of package names
utils::rc.settings(ipck=TRUE)

# use colorout library on rxvt
if(Sys.getenv("TERM") == "rxvt-unicode-256color") {
	library("colorout")
}

ignore.warnings <- function(a.package) {
	suppressWarnings(suppressPackageStartupMessages(
							library(a.package, character.only=TRUE)))
}

# Autoloads packages and ignores warnings
auto.loads <- c("tidyverse", "qcc")
if(interactive()){
	invisible(sapply(auto.loads, ignore.warnings))
}
