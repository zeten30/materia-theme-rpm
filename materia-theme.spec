Name:           materia-theme
Version:        2021.03
Release:        2%{?dist}
Summary:        A Material Design-like theme for GNOME/GTK+ based desktop environments

License:        GPLv2
URL:            https://github.com/nana-4/materia-theme.git
Source0:        materia-theme.tar.gz

BuildArch:      noarch
BuildRequires:  bash
BuildRequires:  bc
Requires:       %{_bindir}/glib-compile-resources
Requires:       %{_datadir}/gtk-engines/murrine.xml
Requires:       gnome-themes-extra
Obsoletes:      Flat-Plat-theme         < %{version}
Obsoletes:      Flat-Plat-light-theme   < %{version}
Obsoletes:      Flat-Plat-dark-theme    < %{version}

%description
Materia is a Material Design-like theme for GNOME/GTK+ based desktop
environments. It supports GTK3, GTK2, Metacity, GNOME Shell, Unity, MATE,
LightDM, GDM, Chrome theme, etc.


%prep
%setup -q -n materia-theme


%build
# Nothing to build
%install
%{__install} -d -m755 %{buildroot}%{_datadir}/themes/
for file in Materia  Materia-compact  Materia-dark  Materia-dark-compact  Materia-light  Materia-light-compact ; do
	%{__cp} -pr ${file} %{buildroot}%{_datadir}/themes
done


%files
%defattr(-,root,root)
%{_datadir}/themes/Materia
%{_datadir}/themes/Materia-compact
%{_datadir}/themes/Materia-dark
%{_datadir}/themes/Materia-dark-compact
%{_datadir}/themes/Materia-light
%{_datadir}/themes/Materia-light-compact


%changelog
* Tue Mar 23 2021 Milan Zink <zeten30@gmail.com> - 2021.03.1

* Fri Oct 25 2019 Milan Zink <zeten30@gmail.com> - 2019.10.1
- gnome-shell 3.34 ready

* Fri Feb 15 2019 Milan Zink <zeten30@gmail.com> - 2019.02.3
- gnome-shell theme hacks - fonts, panel background 

* Mon Feb 11 2019 Milan Zink <zeten30@gmail.com> - 2019.02.1
- initial release
