# RPM Makefile
RELEASE=34
clean:
	rm -rf rpmbuild/*.*

sources: clean
	./create-sources.sh

srpm: sources
	mock -r fedora-$(RELEASE)-x86_64 --spec materia-theme.spec --sources rpmbuild/ --resultdir rpmbuild/ --buildsrpm

rpm: srpm
	mock -r fedora-$(RELEASE)-x86_64 --rebuild rpmbuild/materia-*.src.rpm --resultdir rpmbuild/

copr: srpm
	copr-cli build mzink/Utils rpmbuild/materia-*.src.rpm --nowait
