# Makefile for git-publish

.PHONY: default install docs

default:
	@echo "The default rule does nothing."
	@echo -e "\tinstall\t- Install git-publish."
	@echo -e "\tdocs\t- Generate documentation."

install:
	@sh install.sh


docs:
	asciidoctor -D docs/ docs/src/git-publish.adoc
	asciidoctor -D docs/ -b manpage docs/src/git-publish-man.adoc
