# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ ${PV} == "9999" ] ; then
	EGIT_ECLASS="git-2"
	EGIT_REPO_URI="https://github.com/scarpin0/${PN}.git git://github.com/scarpin0/${PN}.git"
	SYSTEMD_VERSION=">=sys-apps/systemd-207"
	KEYWORDS=""
else
	SYSTEMD_VERSION="~sys-apps/systemd-${PV}"
	SRC_URI="https://github.com/scarpin0/libsystemd-qt/archive/${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64"
fi

inherit cmake-utils ${EGIT_ECLASS}

DESCRIPTION="Qt wrapper for systemd API"
HOMEPAGE="https://github.com/scarpin0/libsystemd-qt"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug qml qt4 +qt5 test"

RDEPEND="
	${SYSTEMD_VERSION}
	qt4? ( dev-qt/qtcore:4 )
	qt5? (
		dev-qt/qtcore:5
		qml? ( dev-qt/qtdeclarative:5 )
	)"
DEPEND="${RDEPEND}
	test? (
		qt4? ( dev-qt/qttest:4 )
		qt5? ( dev-qt/qttest:5 )
	)"

REQUIRED_USE="
	^^ ( qt4 qt5 )
	qml? ( qt5 )
"

DOCS=( README.md )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use qt4 BUILD_WITH_QT4)
		$(cmake-utils_use test BUILD_QTSYSTEMD_TESTS)
		$(cmake-utils_use qml BUILD_QTSYSTEMD_QMLPLUGIN)
	)

	cmake-utils_src_configure
}
